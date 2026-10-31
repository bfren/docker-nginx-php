# Nginx + PHP

![GitHub release (latest by date)](https://img.shields.io/github/v/release/bfren/docker-nginx-php) ![Docker Pulls](https://img.shields.io/endpoint?url=https%3A%2F%2Fbfren.dev%2Fdocker%2Fpulls%2Fnginx-php) ![Docker Image Size](https://img.shields.io/endpoint?url=https%3A%2F%2Fbfren.dev%2Fdocker%2Fsize%2Fnginx-php) ![GitHub Workflow Status](https://img.shields.io/github/actions/workflow/status/bfren/docker-nginx-php/build.yml?branch=main)

[Docker Hub](https://hub.docker.com/r/bfren/nginx-php) - [Quay.io](https://quay.io/repository/bfren/nginx-php) - [bfren ecosystem](https://github.com/bfren/docker)

## Introduction

An image for PHP websites: [nginx](https://github.com/bfren/docker-nginx) and PHP-FPM in one container, with PHP 8.2 to 8.5. [Baïkal](https://github.com/bfren/docker-baikal), [FreshRSS](https://github.com/bfren/docker-freshrss) and [WordPress](https://github.com/bfren/docker-wordpress) are built on it.

It is [Nginx](https://github.com/bfren/docker-nginx) with:

* PHP and PHP-FPM from Alpine's packages, with the session and OPcache extensions
* the official `php.ini`, plus sensible defaults for security, uploads, sessions and OPcache - each one easy to override
* nginx set up to run PHP, with "pretty" URLs routed to `index.php`
* hourly cleaning of old sessions

The PHP set-up comes from the [PHP image](https://github.com/bfren/docker-php) (its `bf-php` module is copied in when this image is built). There is no SSL support - it is designed to run behind a reverse proxy such as [Caddy](https://github.com/bfren/docker-caddy-proxy).

## Quickstart

Serve the PHP site in `./site` on port 8080:

```sh
docker run -d --name web -p 8080:80 -v ./site:/www/public quay.io/bfren/nginx-php:php8.5
```

Or with Docker Compose:

```yaml
services:
  web:
    image: quay.io/bfren/nginx-php:php8.5-9.0
    environment:
      - BF_PHP_EXT=mbstring pdo_mysql
    ports:
      - "8080:80"
    volumes:
      - ./site:/www/public
```

Open `http://localhost:8080`. Requests for files that don't exist are sent to `/index.php`, so front-controller frameworks work without changes.

## Features

* 🐘 PHP 8.2, 8.3, 8.4 and 8.5 - choose with the image tag
* ⚡ PHP-FPM, with OPcache (and the JIT compiler on PHP 8) turned on
* ⚙️ Override `php.ini` and PHP-FPM's `www.conf` with small JSON files
* 🔒 Secure defaults: `allow_url_fopen` off, `phpinfo()` disabled, HTTP-only secure session cookies, session upload progress off, and the environment hidden from PHP unless you choose otherwise
* 🧹 Expired sessions cleaned every hour
* 🗜️ Everything from [Nginx](https://github.com/bfren/docker-nginx#features): compression, helper files, logs, daily reload and a health check

## Tags

Images are published to Docker Hub (`bfren/nginx-php`) and Quay.io (`quay.io/bfren/nginx-php`) for `linux/amd64`, `linux/arm/v7` and `linux/arm64`. Tags start with the PHP version.

| Tag                | Example           | Use when                                              |
| ------------------ | ----------------- | ----------------------------------------------------- |
| `phpX.Y`           | `php8.5`          | You want the latest image for a PHP version           |
| `phpX.Y-MAJOR`     | `php8.5-9`        | You want updates, but not breaking changes            |
| `phpX.Y-MINOR`     | `php8.5-9.0`      | You want fixes only - **recommended for building on** |
| `phpX.Y-VERSION`   | `php8.5-9.0.4`    | You want to pin this image exactly                    |
| `phpX.Y.Z`         | `php8.5.11`       | You want an exact PHP release                         |
| `phpX.Y.Z-VERSION` | `php8.5.11-9.0.4` | You want to pin both                                  |

There is no `latest` tag - always choose a PHP version.

| PHP | Release | nginx | Alpine | PHP security support ends |
| --- | ------- | ----- | ------ | ------------------------- |
| 8.5 | 8.5.11  | 1.30  | 3.24   | 2029-12-31                |
| 8.4 | 8.4.26  | 1.30  | 3.24   | 2028-12-31                |
| 8.3 | 8.3.35  | 1.30  | 3.24   | 2027-12-31                |
| 8.2 | 8.2.33  | 1.28  | 3.22   | 2026-12-31                |

## Configuration

### Ports

| Port | Purpose                                            |
| ---- | -------------------------------------------------- |
| `80` | HTTP - put a reverse proxy in front of it for SSL. |

### Volumes

| Volume | Purpose                                                                                                       |
| ------ | ------------------------------------------------------------------------------------------------------------- |
| `/www` | Files in `/www/public` are served. If you don't mount anything, a "Welcome to Nginx + PHP FPM" page is shown. |

### Environment Variables

| Variable          | Values                      | Description                                                                                                        | Default           |
| ----------------- | --------------------------- | ------------------------------------------------------------------------------------------------------------------ | ----------------- |
| `BF_PHP_EXT`      | space-separated list        | Extensions to install at every start, e.g. `mbstring pdo_mysql` (see [Extensions](#extensions)).                   | *blank*           |
| `BF_PHP_ENV`      | `production`, `development` | Which official `php.ini` to use.                                                                                   | `production`      |
| `BF_PHP_LOAD_ENV` | `0`, `1`                    | Pass every `BF_PHP_*` variable through to PHP (see [Environment variables in PHP](#environment-variables-in-php)). | `0`               |
| `BF_PHP_DIR`      | path                        | PHP's configuration folder - set by the image, don't change it.                                                    | e.g. `/etc/php85` |
| `BF_PHP_PREFIX`   | e.g. `php85`                | Alpine's package prefix for this PHP version - set by the image, don't change it.                                  | e.g. `php85`      |

[Nginx](https://github.com/bfren/docker-nginx#environment-variables) adds the nginx variables (access log, health check URI, …), and [Alpine + S6](https://github.com/bfren/docker-alpine-s6#environment-variables) adds timezone and cron.

## How It Works

### Starting

When the container starts, [Nginx](https://github.com/bfren/docker-nginx#starting) sets up nginx, then this image's initialisation scripts run:

| Script           | Does                                                                            |
| ---------------- | ------------------------------------------------------------------------------- |
| `20-env.nu`      | Sets the PHP paths.                                                             |
| `21-ext.nu`      | Installs the extensions in `BF_PHP_EXT`.                                        |
| `22-php-ini.nu`  | Downloads the `php.ini` for `BF_PHP_ENV` if needed, and applies your overrides. |
| `23-www-conf.nu` | Applies your overrides to PHP-FPM's `www.conf`.                                 |
| `24-php-env.nu`  | Passes `BF_PHP_*` variables to PHP, if `BF_PHP_LOAD_ENV=1`.                     |

Then S6 starts nginx and `php-fpm`. `php-fpm` checks its configuration (`php-fpm -t`) first, and if it fails, or PHP-FPM stops unexpectedly, the container stops.

### nginx and PHP

nginx passes requests to PHP-FPM on `127.0.0.1:9000` (the `php-fpm` upstream). The default site uses `index.php` as the index page, plus two helper files you can use in your own sites:

| Helper             | Description                                                                            |
| ------------------ | -------------------------------------------------------------------------------------- |
| `php-try-all.conf` | Serves a file or folder if it exists, and otherwise sends the request to `/index.php`. |
| `php-try-php.conf` | Sends `.php` requests to PHP-FPM (and returns 404 if the file doesn't exist).          |

Include them with `include helpers/php-try-all.conf;` - see [Nginx](https://github.com/bfren/docker-nginx#configuration-files) for how sites and helpers work.

### `php.ini`

The official `php.ini` is downloaded when the image is built (see [PHP](https://github.com/bfren/docker-php#phpini)). At every start, the JSON files in `/etc/bf/php.d` are read in name order, later files replacing earlier values, and each value is set in `php.ini`. The image's defaults are:

| File              | Settings                                                                                                                        |
| ----------------- | ------------------------------------------------------------------------------------------------------------------------------- |
| `00-php-ini.json` | `allow_url_fopen = Off`, `disable_functions = phpinfo`, `memory_limit = 256M`, `error_log` empty                                |
| `01-session.json` | Session cookies HTTP-only and secure (HTTPS only), strict mode, lifetime 1 day, name `bf-nginx-php-sessid`, upload progress off |
| `02-upload.json`  | `post_max_size` and `upload_max_filesize` 64M                                                                                   |
| `03-jit.json`     | OPcache on, with the `tracing` JIT and a 128M buffer                                                                            |

To change or add settings, add your own file - e.g. mount `./php.json` to `/etc/bf/php.d/10-site.json`:

```json
{
    "memory_limit": "512M",
    "upload_max_filesize": "256M",
    "post_max_size": "256M"
}
```

The PHP image's `/php-ini.json` is **not** used here - use `/etc/bf/php.d` instead.

### PHP-FPM settings (`www.conf`)

The same works for PHP-FPM: at every start, the JSON files in `/etc/bf/php-fpm.d` are applied to `www.conf`. PHP-FPM runs as the `www` user, and the defaults are `catch_workers_output = yes`, `decorate_workers_output = no` and `clear_env = yes`. For example, to allow more PHP processes:

```json
{
    "pm.max_children": "20"
}
```

### Environment variables in PHP

`clear_env = yes` means PHP can't see the container's environment variables - so secrets passed to the container aren't readable by every script. To pass some through, name them `BF_PHP_…` and set `BF_PHP_LOAD_ENV=1`. Every `BF_PHP_*` variable is then available to PHP by the same name:

```php
$host = getenv('BF_PHP_DB_HOST');
```

This includes the image's own `BF_PHP_*` variables (e.g. `BF_PHP_DIR`), which are harmless.

### Extensions

`BF_PHP_EXT` installs extensions as Alpine packages at **every** start, so the container needs internet access and starts more slowly. That's convenient for trying things out, but for anything you deploy, install them when you build your own image instead (see [Building on this image](#building-on-this-image) and [PHP](https://github.com/bfren/docker-php#extensions)).

### Sessions

Every hour, a cron job runs PHP's session clean-up as the `www` user, removing sessions older than `session.gc_maxlifetime` (1 day by default, or your override).

### Health check, logs and reloading

These come from [Nginx](https://github.com/bfren/docker-nginx#health-check). The health check loads `http://localhost`, so with the default site it checks PHP-FPM too.

### The `bf-nginx-php` module

| Command                            | Use                                                                            |
| ---------------------------------- | ------------------------------------------------------------------------------ |
| `bf-nginx-php conf test`           | Test the PHP-FPM configuration.                                                |
| `bf-nginx-php override get_values` | Read and merge the JSON files in a folder (used for `php.ini` and `www.conf`). |
| `bf-nginx-php sessions clean`      | Remove expired sessions (run hourly).                                          |
| `bf-nginx-php load-env`            | Add environment variables to PHP-FPM's `www.conf`.                             |

The [`bf-php` module](https://github.com/bfren/docker-php#the-bf-php-module) is also available.

## Building on this image

```dockerfile
FROM quay.io/bfren/nginx-php:php8.5-9.0

COPY ./overlay /
RUN bf-install
```

`overlay/tmp/install`:

```nu
#!/usr/bin/nu

use bf
use bf-php

# Install my-site
def main [] {
    bf-php ext install [mbstring pdo_mysql]
}
```

Put your site in `overlay/www/public` (or mount it), nginx configuration in `overlay/etc/nginx/sites` or `custom`, and `php.ini` settings in `overlay/etc/bf/php.d`. See [Nginx](https://github.com/bfren/docker-nginx#building-on-this-image) for the rest.

## Testing

```sh
./test.nu        # builds the PHP 8.5 image and runs /test
./test.nu 8.2    # the same for PHP 8.2
./test.nu --all  # every version, in parallel
./run.sh         # builds the PHP 8.5 image and opens a shell (port 3000)
```

`/test` runs this image's tests alongside the base images' tests, and fails if tests don't execute. As well as [the PHP image's tests](https://github.com/bfren/docker-php#testing), they check that `php-fpm` links to the versioned executable, the session and OPcache extensions are loaded, the PHP-FPM configuration is valid, override files merge in the right order, and `BF_PHP_LOAD_ENV` writes the right lines to `www.conf`.

## Troubleshooting

### Logins or sessions don't work over HTTP

Session cookies are secure by default, so browsers only send them over HTTPS. Use HTTPS (e.g. through your proxy), or for local testing add `{"session.cookie_secure": "0"}` to a file in `/etc/bf/php.d`.

### The container stops at start-up

PHP-FPM's configuration test failed - often a bad value in a `/etc/bf/php-fpm.d` file. Run with `BF_DEBUG=1` and check `docker logs`.

### "Call to undefined function"

The function's extension isn't installed - add it with `BF_PHP_EXT` or in your own image. Package names are at [pkgs.alpinelinux.org](https://pkgs.alpinelinux.org).

### `getenv()` returns nothing

PHP can't see the container's environment - see [Environment variables in PHP](#environment-variables-in-php).

### `file_get_contents('https://…')` fails

`allow_url_fopen` is off by default. Use curl (`BF_PHP_EXT=curl`), or turn it on in a `/etc/bf/php.d` file.

## FAQs

### Why nginx and PHP-FPM in one container?

One container per site is simpler to run and back up, and S6 supervises both processes - if either fails, the container stops so Docker can restart it.

## Licence

> [MIT](https://mit.bfren.dev/2020)

## Copyright

> Copyright (c) 2020-2026 [bfren](https://bfren.dev) (unless otherwise stated)

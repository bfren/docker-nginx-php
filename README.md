# Docker Nginx PHP

![GitHub release (latest by date)](https://img.shields.io/github/v/release/bfren/docker-nginx-php) ![Docker Pulls](https://img.shields.io/endpoint?url=https%3A%2F%2Fbfren.dev%2Fdocker%2Fpulls%2Fnginx-php) ![Docker Image Size](https://img.shields.io/endpoint?url=https%3A%2F%2Fbfren.dev%2Fdocker%2Fsize%2Fnginx-php) ![GitHub Workflow Status](https://img.shields.io/github/actions/workflow/status/bfren/docker-nginx-php/dev.yml?branch=main)

[Docker Repository](https://hub.docker.com/r/bfren/nginx-php) - [bfren ecosystem](https://github.com/bfren/docker)

Nginx plus PHP (7.4, 8.0, 8.1, 8.2, 8.3, 8.4 and 8.5) - no SSL support etc, designed to be used behind a proxy server.  Minimal PHP packages are installed:

* `php`
* `php-common`
* `php-fpm`
* `php-session`

Nginx is setup by default to run PHP in FPM mode.  To override values in www.conf map a `xx.json` file to `/etc/bf/php-fpm.d` - see `www-conf-sample.json`.  Values in the php.ini file can be overridden in the same way - see [Docker PHP](https://github.com/bfren/docker-php) for more information and a sample file.

## Contents

* [Ports](#ports)
* [Volumes](#volumes)
* [Environment Variables](#environment-variables)
* [Nginx Configuration Helpers](#nginx-configuration-helpers)
* [Licence / Copyright](#licence)

## Ports

* 80

## Volumes

| Volume   | Purpose            |
| -------- | ------------------ |
| `/www`   | *From base image.* |

## Environment Variables

See [Docker PHP](https://github.com/bfren/docker-php) for configuration instructions.

## Nginx Configuration Helpers

The image contains a handful of useful Nginx configuration 'helper' files, which you can find in `/overlay/etc/nginx/helpers`.  They all begin with the prefix 'php':

| Helper          | Description                                                |
| --------------- | ---------------------------------------------------------- |
| `-try-all.conf` | Enables SEO-friendly URLs (e.g. without `index.php`).      |
| `-try-php.conf` | Sends the request to upstream PHP FastCGI Process Manager. |

## Licence

> [MIT](https://mit.bfren.dev/2020)

## Copyright

> Copyright (c) 2020-2025 [bfren](https://bfren.dev) (unless otherwise stated)

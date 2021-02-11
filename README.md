# Docker Nginx PHP

![GitHub release (latest by date)](https://img.shields.io/github/v/release/bencgreen/docker-nginx-php) ![GitHub Workflow Status](https://img.shields.io/github/workflow/status/bencgreen/docker-nginx-php/7.3-dev?label=github+7.3) ![GitHub Workflow Status](https://img.shields.io/github/workflow/status/bencgreen/docker-nginx-php/7.4-dev?label=github+7.4) ![GitHub Workflow Status](https://img.shields.io/github/workflow/status/bencgreen/docker-nginx-php/8.0-edge?label=github+8.0) ![Docker Cloud Build Status](https://img.shields.io/docker/cloud/build/bcgdesign/nginx-php?label=docker) ![Docker Pulls](https://img.shields.io/docker/pulls/bcgdesign/nginx-php?label=pulls) ![Docker Image Size (tag)](https://img.shields.io/docker/image-size/bcgdesign/nginx-php/latest?label=size)

[Docker Repository](https://hub.docker.com/r/bcgdesign/nginx-php) - [bcg|design ecosystem](https://github.com/bencgreen/docker)

Nginx plus PHP (7.3.27, 7.4.15, and 8.0.2) - no SSL support etc, designed to be used behind a proxy server.  Minimal PHP packages are installed:

* `php7` or `php8`
* `php7-common` or `php8-common`
* `php7-fpm` or `php8-fpm`
* `php7-session` or `php8-session`

Nginx is setup by default to run PHP in FPM mode.

Additionally, `bash` is installed as it is required by some of the setup scripts.

## Contents

* [Ports](#ports)
* [Volumes](#volumes)
* [Environment Variables](#environment-variables)
* [Helper Functions](#helper-functions)
* [Nginx Configuration Helpers](#nginx-configuration-helpers)
* [Authors / Licence / Copyright](#authors)

## Ports

* 80

## Volumes

| Volume   | Purpose            |
| -------- | ------------------ |
| `/www`   | *From base image.* |

## Environment Variables

### php.ini

| Variable  | Values                        | Description                                                                    | Default      |
| --------- | ----------------------------- | ------------------------------------------------------------------------------ | ------------ |
| `PHP_INI` | 'production' or 'development' | Defines which official php.ini template to use, "production" or "development". | 'production' |

The following environment variables will override values in `php.ini` (see [here](https://www.php.net/manual/en/ini.list.php)):

| Variable                         | Directive              | Default Value |
| -------------------------------- | ---------------------- | ------------- |
| `PHP_INI_DISPLAY_ERRORS`         | display_errors         | *None*        |
| `PHP_INI_DISPLAY_STARTUP_ERRORS` | display_startup_errors | *None*        |
| `PHP_INI_ERROR_REPORTING`        | error_reporting        | *None*        |
| `PHP_INI_MEMORY_LIMIT`           | memory_limit           | 256M          |
| `PHP_INI_MAX_UPLOAD`             | upload_max_filesize    | 64M           |
| `PHP_INI_MAX_POST`               | post_max_size          | 64M           |

### FPM Configuration

The following environment variables will override values in `php-fpm.d/www.conf` (see [here](https://www.php.net/manual/en/install.fpm.configuration.php)):

| Variable            | Directive | Default Value |
| ------------------- | --------- | ------------- |
| `PHP_FPM_LOG_LEVEL` | log_level | 'notice'      |

## Helper Functions

| Function             | Arguments | Description                                                 |
| -------------------- | --------- | ----------------------------------------------------------- |
| `php-clean-sessions` | *None*    | Cleans PHP session information - the cron runs this hourly. |

## Nginx Configuration Helpers

The image contains a handful of useful Nginx configuration 'helper' files, which you can find in `/overlay/etc/nginx/helpers`.  They all begin with the prefix 'php':

| Helper          | Description                                                |
| --------------- | ---------------------------------------------------------- |
| `-try-all.conf` | Enables SEO-friendly URLs (e.g. without `index.php`).      |
| `-try-php.conf` | Sends the request to upstream PHP FastCGI Process Manager. |

## Authors

* [Ben Green](https://github.com/bencgreen)

## License

> MIT

## Copyright

> Copyright (c) 2021 Ben Green <https://bcgdesign.com>
> Unless otherwise stated

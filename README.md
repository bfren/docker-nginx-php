# Docker Nginx PHP

![Docker Image Version (tag latest semver)](https://img.shields.io/docker/v/bcgdesign/nginx-php/latest?label=latest) ![GitHub Workflow Status](https://img.shields.io/github/workflow/status/bencgreen/docker-nginx-php/7.3-dev?label=github+7.3) ![GitHub Workflow Status](https://img.shields.io/github/workflow/status/bencgreen/docker-nginx-php/7.4-dev?label=github+7.4) ![GitHub Workflow Status](https://img.shields.io/github/workflow/status/bencgreen/docker-nginx-php/8.0-edge?label=github+8.0) ![Docker Cloud Build Status](https://img.shields.io/docker/cloud/build/bcgdesign/nginx-php?label=docker) ![Docker Pulls](https://img.shields.io/docker/pulls/bcgdesign/nginx-php?label=pulls) ![Docker Image Size (tag)](https://img.shields.io/docker/image-size/bcgdesign/nginx-php/latest?label=size)

[Docker Repository](https://hub.docker.com/r/bcgdesign/nginx-php) - [bcg|design ecosystem](https://github.com/bencgreen/docker)

Nginx plus PHP (7.4.14) - no SSL support etc, designed to be used behind a proxy server.  Minimal PHP packages are installed:

* `php7`
* `php7-common`
* `php7-fpm`
* `php7-session`

Nginx is setup by default to run PHP in FPM mode.

Additionally, `bash` is installed as it is required by some of the setup scripts.

## Ports

* 80

## Volumes

* `/www` - these files will be served by Nginx (by default there is a 'Welcome to Nginx' message served)

## Environment Variables

```bash
PHP_INI="production"`# defines which official template to use, "production" or "development"
```

The following environment variables will override values in `/etc/php7/php-fpm.d/www.conf`:

```bash
PHP_FPM_LOG_LEVEL="notice" # log_level
```

The following environment variables will override values in `/etc/php7/php.ini`:

```bash
PHP_INI_DISPLAY_ERRORS= # display_errors
PHP_INI_DISPLAY_STARTUP_ERRORS= # display_startup_errors
PHP_INI_ERROR_REPORTING= # error_reporting
PHP_INI_MEMORY_LIMIT="256M" # memory_limit
PHP_INI_MAX_UPLOAD="64M" # upload_max_filesize
PHP_INI_MAX_POST="64M" # post_max_size
```

## Authors

* [Ben Green](https://github.com/bencgreen)

## License

> MIT

## Copyright

> Copyright (c) 2021 Ben Green <https://bcgdesign.com>  
> Unless otherwise stated

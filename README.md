# Docker Nginx + PHP

![build](https://github.com/bencgreen/docker-nginx-php/workflows/build/badge.svg)

[Docker Repository](https://hub.docker.com/r/bcgdesign/nginx-php)

Nginx plus PHP (7.4.12) - no SSL support etc, designed to be used behind a proxy server.  Minimal PHP packages are installed:

* `php7`
* `php7-common`
* `php7-fpm`
* `php7-session`

Nginx is setup by default to run PHP in FPM mode.

## Ports

* 80

## Environment Variables

* `PHP_INI="production"` - defines which official template to use, "production" or "development"

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

## Volumes

See the [Nginx](https://github.com/bencgreen/docker-nginx) image.

## Authors

* [Ben Green](https://github.com/bencgreen)

## License

> MIT

## Copyright

> Copyright (c) 2020 Ben Green <https://bcgdesign.com>  
> Unless otherwise stated

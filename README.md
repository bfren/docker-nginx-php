# Docker Nginx + PHP

![build](https://github.com/bencgreen/docker-nginx-php/workflows/build/badge.svg)

[Docker Repository](https://hub.docker.com/r/bcgdesign/nginx-php)

Nginx plus PHP (7.4.12) - no SSL support etc, designed to be used behind a proxy server.  Minimal PHP packages are installed:

* php7
* php7-common
* php7-fpm
* php7-session

Nginx is setup by default to run PHP in FPM mode.

## Ports

* 80

## Volumes

* `/www` - these files will be served by Nginx
* `/etc/nginx/conf.d` - custom Nginx configuration
* `/etc/nginx/modules` - Nginx modules
* `/etc/nginx/sites` - server definitions

## Authors

* [Ben Green](https://github.com/bencgreen)

## License

> MIT

## Copyright

> Copyright (c) 2020 Ben Green <https://bcgdesign.com>  
> Unless otherwise stated

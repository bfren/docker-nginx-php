FROM bcgdesign/nginx:alpine-3.13-1.5.0

LABEL maintainer="Ben Green <ben@bcgdesign.com>" \
    org.label-schema.name="Nginx + PHP" \
    org.label-schema.version="8.0" \
    org.label-schema.vendor="Ben Green" \
    org.label-schema.schema-version="1.0"

ENV PHP_FPM_LOG_LEVEL="notice" \
    PHP_INI="production" \
    PHP_INI_DISPLAY_ERRORS= \
    PHP_INI_DISPLAY_STARTUP_ERRORS= \
    PHP_INI_ERROR_LOG="/var/log/php8/error.log" \
    PHP_INI_ERROR_REPORTING= \
    PHP_INI_MEMORY_LIMIT="256M" \
    PHP_INI_MAX_POST="64M" \
    PHP_INI_MAX_UPLOAD="64M" \
    PHP_SESSION_MAX_LIFETIME=86400

COPY ./overlay /
COPY ./8.0/overlay /
COPY ./8.0/PHP_BUILD /tmp/VERSION

RUN bcg-install

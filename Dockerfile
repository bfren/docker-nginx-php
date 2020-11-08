FROM bcgdesign/nginx:latest

LABEL maintainer="Ben Green <ben@bcgdesign.com>" \
    org.label-schema.name="Nginx + PHP" \
    org.label-schema.version="latest" \
    org.label-schema.vendor="Ben Green" \
    org.label-schema.schema-version="1.0"

ENV PHP_INI="development"
ENV PHP_DISPLAY_ERRORS=
ENV PHP_DISPLAY_STARTUP_ERRORS=
ENV PHP_ERROR_REPORTING=
ENV PHP_MEMORY_LIMIT="256M"
ENV PHP_MAX_UPLOAD="64M"
ENV PHP_MAX_POST="64M"

RUN apk update \
    && apk upgrade \
    && apk add \
        curl \
        php7 \
        php7-common \
        php7-fpm \
        php7-session \
    && rm -rf /var/cache/apk/*

COPY ./overlay /

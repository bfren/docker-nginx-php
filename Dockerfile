FROM bcgdesign/nginx:1.0.3

LABEL maintainer="Ben Green <ben@bcgdesign.com>" \
    org.label-schema.name="Nginx + PHP" \
    org.label-schema.version="latest" \
    org.label-schema.vendor="Ben Green" \
    org.label-schema.schema-version="1.0"

ENV PHP_INI="production"
ENV PHP_DISPLAY_ERRORS=
ENV PHP_DISPLAY_STARTUP_ERRORS=
ENV PHP_ERROR_REPORTING=
ENV PHP_MEMORY_LIMIT="256M"
ENV PHP_MAX_UPLOAD="64M"
ENV PHP_MAX_POST="64M"

ARG VERSION="7.4.12-r0"

RUN apk update \
    && apk upgrade \
    && apk add \
        curl \
        php7=${VERSION} \
        php7-common=${VERSION} \
        php7-fpm=${VERSION} \
        php7-session=${VERSION} \
    && rm -rf /var/cache/apk/*

COPY ./overlay /

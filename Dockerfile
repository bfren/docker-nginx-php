FROM bcgdesign/nginx:1.18.0

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

COPY ./VERSION /tmp/VERSION
RUN export PHP_VERSION=$(cat /tmp/VERSION)

RUN apk update \
    && apk upgrade \
    && apk add \
        curl \
        php7=${PHP_VERSION} \
        php7-common=${PHP_VERSION} \
        php7-fpm=${PHP_VERSION} \
        php7-session=${PHP_VERSION} \
    && rm -rf /var/cache/apk/* /tmp/*

COPY ./overlay /

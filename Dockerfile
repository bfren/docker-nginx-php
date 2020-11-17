FROM bcgdesign/nginx:1.18.0-r9

LABEL maintainer="Ben Green <ben@bcgdesign.com>" \
    org.label-schema.name="Nginx + PHP" \
    org.label-schema.version="latest" \
    org.label-schema.vendor="Ben Green" \
    org.label-schema.schema-version="1.0"

ENV PHP_FPM_LOG_LEVEL="notice" \
    PHP_INI="production" \
    PHP_INI_DISPLAY_ERRORS= \
    PHP_INI_DISPLAY_STARTUP_ERRORS= \
    PHP_INI_ERROR_REPORTING= \
    PHP_INI_MEMORY_LIMIT="256M" \
    PHP_INI_MAX_POST="64M" \
    PHP_INI_MAX_UPLOAD="64M" \
    PHP_SESSION_MAX_LIFETIME=86400

COPY ./VERSION /tmp/VERSION
RUN export PHP_VERSION=$(cat /tmp/VERSION) \
    && echo "PHP v${PHP_VERSION}" \
    && apk -U upgrade \
    && apk add \
        bash \
        php7=${PHP_VERSION} \
        php7-common=${PHP_VERSION} \
        php7-fpm=${PHP_VERSION} \
        php7-session=${PHP_VERSION} \
    && rm -rf /var/cache/apk/* /www/* /tmp/*

COPY ./overlay /

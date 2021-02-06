FROM bcgdesign/nginx:alpine-3.13-1.2.4

LABEL maintainer="Ben Green <ben@bcgdesign.com>" \
    org.label-schema.name="Nginx + PHP" \
    org.label-schema.version="latest" \
    org.label-schema.vendor="Ben Green" \
    org.label-schema.schema-version="1.0"

ENV PHP_FPM_LOG_LEVEL="notice" \
    PHP_INI="production" \
    PHP_INI_DISPLAY_ERRORS= \
    PHP_INI_DISPLAY_STARTUP_ERRORS= \
    PHP_INI_ERROR_LOG="/var/log/php/errors.log" \
    PHP_INI_ERROR_REPORTING= \
    PHP_INI_MEMORY_LIMIT="256M" \
    PHP_INI_MAX_POST="64M" \
    PHP_INI_MAX_UPLOAD="64M" \
    PHP_SESSION_MAX_LIFETIME=86400

ENV PHP_DIR=/etc/php7

COPY ./7.4/PHP_BUILD /tmp/PHP_BUILD
RUN export PHP_VERSION=$(cat /tmp/PHP_BUILD) \
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
COPY ./overlay-nginx-conf /etc/nginx/http.d
COPY ./7.4/php-fpm /etc/services.d/php-fpm

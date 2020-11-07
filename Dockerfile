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

RUN apk update && \
    apk upgrade && \
    apk add curl \
        php7 \
        php7-bcmath \
        php7-common \
        php7-ctype \
        php7-curl \
        php7-dom \
        php7-fileinfo \
        php7-fpm \
        php7-gd \
        php7-gettext \
        php7-iconv \
        php7-intl \
        php7-json \
        php7-mbstring \
        php7-mcrypt \
        php7-mysqlnd \
        php7-opcache \
        php7-openssl \
        php7-pdo \
        php7-pdo_mysql \
        php7-pdo_pgsql \
        php7-pdo_sqlite \
        php7-session \ 
        php7-simplexml \
        php7-xml \
        php7-xmlreader \
        php7-xmlwriter \
        php7-zip \
    rm -rf /var/cache/apk/*

COPY ./overlay /

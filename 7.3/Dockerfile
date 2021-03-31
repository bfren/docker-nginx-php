FROM bcgdesign/nginx:alpine3.12-2.0.9

LABEL maintainer="Ben Green <ben@bcgdesign.com>" \
    org.label-schema.name="Nginx + PHP" \
    org.label-schema.version="7.3" \
    org.label-schema.vendor="Ben Green" \
    org.label-schema.schema-version="1.0"

ENV \
    # www.conf override: log_level
    PHP_FPM_LOG_LEVEL="notice" \
    # php.ini template to use
    PHP_INI="production" \
    # php.ini override: display_errors
    PHP_INI_DISPLAY_ERRORS= \
    # php.ini override: display_startup_errors
    PHP_INI_DISPLAY_STARTUP_ERRORS= \
    # php.ini override: error_log
    PHP_INI_ERROR_LOG="/var/log/php7/error.log" \
    # php.ini override: err-r_reporting
    PHP_INI_ERROR_REPORTING= \
    # php.ini override: memory_limit
    PHP_INI_MEMORY_LIMIT="256M" \
    # php.ini override: max_post
    PHP_INI_MAX_POST="64M" \
    # php.ini override: max_upload
    PHP_INI_MAX_UPLOAD="64M" \
    # php.ini override: session_max_lifetime
    PHP_SESSION_MAX_LIFETIME=86400

COPY ./overlay /
COPY ./7.3/overlay /
COPY ./7.3/PHP_BUILD /tmp/VERSION

RUN bcg-install

FROM bfren/nginx:nginx1.22-4.0.27

LABEL org.opencontainers.image.source="https://github.com/bfren/docker-nginx-php"

ARG BF_IMAGE
ARG BF_VERSION

ENV \
    # PHP config directory
    PHP_DIR="/etc/php82" \
    # www.conf override: log_level
    PHP_FPM_LOG_LEVEL="notice" \
    # php.ini template to use, or 'custom' if you want to bind your own custom php.ini -
    # which will cause the other PHP_INI_* environment variables to be ignored
    PHP_INI="production" \
    # php.ini override: display_errors
    PHP_INI_DISPLAY_ERRORS= \
    # php.ini override: display_startup_errors
    PHP_INI_DISPLAY_STARTUP_ERRORS= \
    # php.ini override: error_log
    PHP_INI_ERROR_LOG="/var/log/php82/error.log" \
    # php.ini override: err-r_reporting
    PHP_INI_ERROR_REPORTING= \
    # php.ini override: memory_limit
    PHP_INI_MEMORY_LIMIT="256M" \
    # php.ini override: max_post
    PHP_INI_MAX_POST="64M" \
    # php.ini override: max_upload
    PHP_INI_MAX_UPLOAD="64M" \
    # php.ini override: session_max_lifetime
    PHP_SESSION_MAX_LIFETIME=86400 \
    # space-separated extensions to install on startup
    PHP_EXT=

COPY ./overlay /
COPY ./8.2/overlay /

RUN bf-install

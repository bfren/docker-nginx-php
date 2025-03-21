#======================================================================================================================
# STAGE 0: get Nu scripts from the PHP image overlay
#======================================================================================================================

FROM ghcr.io/bfren/alpine AS php

WORKDIR /tmp
RUN \
    # get the Nu scripts from the PHP image overlay
    echo "Cloning Alpine overlay." && \
    apk add git && git clone --branch v2.3.5 https://github.com/bfren/docker-php.git && \
    mkdir /overlay && \
    mv docker-php/overlay/etc /overlay/


#======================================================================================================================
# STAGE 1: create final image
#======================================================================================================================

FROM ghcr.io/bfren/nginx:nginx1.26-alpine3.21-6.4.4 AS final
COPY --from=php /overlay /

LABEL org.opencontainers.image.source="https://github.com/bfren/docker-nginx-php"

ARG BF_IMAGE
ARG BF_PUBLISHING
ARG BF_VERSION

COPY ./overlay /
COPY ./8.4/overlay /

ENV \
    # PHP config directory
    BF_PHP_DIR="/etc/php84" \
    # offical php.ini template to download
    BF_PHP_ENV="production" \
    # space-separated extensions to install on startup
    BF_PHP_EXT= \
    # PHP package prefix
    BF_PHP_PREFIX="php84"

RUN bf-install

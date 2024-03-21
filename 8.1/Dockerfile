#======================================================================================================================
# STAGE 0: get Nu scripts from the PHP image overlay
#======================================================================================================================

FROM alpine AS php

WORKDIR /tmp
RUN \
    # get the Nu scripts from the PHP image overlay
    echo "Cloning Alpine overlay." && \
    apk add git && git clone --branch v2.2.1 https://github.com/bfren/docker-php.git && \
    mkdir /overlay && \
    mv docker-php/overlay/etc /overlay/


#======================================================================================================================
# STAGE 1: create final image
#======================================================================================================================

FROM bfren/nginx:nginx1.24-alpine3.19-6.2.1 as final
COPY --from=php /overlay /

LABEL org.opencontainers.image.source="https://github.com/bfren/docker-nginx-php"

ARG BF_IMAGE
ARG BF_PUBLISHING
ARG BF_VERSION

COPY ./overlay /
COPY ./8.1/overlay /

ENV \
    # PHP config directory
    BF_PHP_DIR="/etc/php81" \
    # offical php.ini template to download
    BF_PHP_ENV="production" \
    # space-separated extensions to install on startup
    BF_PHP_EXT= \
    # PHP package prefix
    BF_PHP_PREFIX="php81"

RUN bf-install

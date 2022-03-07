#!/bin/sh

IMAGE=`cat VERSION`
PHP=${1:-8.0}

docker buildx build \
    --build-arg BF_IMAGE=nginx-php \
    --build-arg BF_VERSION=${IMAGE} \
    -f ${PHP}/Dockerfile \
    -t nginx-php${PHP}-dev \
    . \
    && \
    docker run -it nginx-php${PHP}-dev sh

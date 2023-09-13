#!/bin/sh

IMAGE=`cat VERSION`
PHP=${1:-8.2}

docker buildx build \
    --load \
    --build-arg BF_IMAGE=nginx-php \
    --build-arg BF_VERSION=${IMAGE} \
    -f ${PHP}/Dockerfile \
    -t nginx-php${PHP}-dev \
    . \
    && \
    docker run -it nginx-php${PHP}-dev sh

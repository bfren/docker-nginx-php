#!/bin/sh

IMAGE=`cat VERSION`
PHP=${1:-8.5}

docker buildx build \
    --load \
    --no-cache \
    --progress plain \
    --build-arg BF_IMAGE=nginx-php \
    --build-arg BF_VERSION=${IMAGE} \
    -f ${PHP}/Dockerfile \
    -t nginx-php${PHP}-dev \
    . \
    && \
    docker run -it -e BF_DEBUG=1 -e BF_PHP_EXT=mysqli nginx-php${PHP}-dev sh

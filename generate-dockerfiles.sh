#!/bin/bash

set -euo pipefail

docker pull bfren/alpine

BASE_VERSION="6.1.2"
PHP_BRANCH="v2.1.4"
PHP_VERSIONS="7.4 8.0 8.1 8.2 8.3"

for V in ${PHP_VERSIONS} ; do

    echo "PHP ${V}"
    NGINX_BASE=`cat ./${V}/NGINX_BASE`
    PHP_PREFIX=`cat ./${V}/PHP_PREFIX`
    PHP_DIR="/etc/${PHP_PREFIX}"

    DOCKERFILE=$(docker run \
        -v ${PWD}:/ws \
        -e BF_DEBUG=0 \
        bfren/alpine esh \
        "/ws/Dockerfile.esh" \
        BASE_VERSION=${BASE_VERSION} \
        NGINX_BASE=${NGINX_BASE} \
        PHP_BRANCH=${PHP_BRANCH} \
        PHP_DIR=${PHP_DIR} \
        PHP_MINOR=${V} \
        PHP_PREFIX=${PHP_PREFIX}
    )

    echo "${DOCKERFILE}" > ./${V}/Dockerfile

done

docker system prune -f
echo "Done."

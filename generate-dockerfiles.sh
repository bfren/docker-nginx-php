#!/bin/bash

set -euo pipefail

docker pull bfren/alpine

BASE_REVISION="3.0.2"
echo "Base: ${BASE_REVISION}"

PHP_VERSIONS="7.3 7.4 7.4-edge 8.0 8.0-edge"
for V in ${PHP_VERSIONS} ; do

    echo "PHP ${V}"
    PHP_MAJOR="$(echo ${V} | cut -c 1)"
    NGINX_BASE=`cat ./${V}/NGINX_BASE`

    DOCKERFILE=$(docker run \
        -v ${PWD}:/ws \
        -e BF_DEBUG=0 \
        bfren/alpine esh \
        "/ws/Dockerfile.esh" \
        BASE_REVISION=${BASE_REVISION} \
        NGINX_BASE=${NGINX_BASE} \
        PHP_MAJOR=${PHP_MAJOR} \
        PHP_MINOR=${V}
    )

    echo "${DOCKERFILE}" > ./${V}/Dockerfile

done

docker system prune -f
echo "Done."

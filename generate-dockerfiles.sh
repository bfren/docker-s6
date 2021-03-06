#!/bin/bash

set -euo pipefail

docker pull bfren/alpine

BASE_REVISION="1.3.3"
echo "Base: ${BASE_REVISION}"

ALPINE_VERSIONS="3.12 3.13 3.14 3.15 edge"
for V in ${ALPINE_VERSIONS} ; do

    echo "Alpine ${V}"
    ALPINE_REVISION=`cat ./${V}/ALPINE_REVISION`

    DOCKERFILE=$(docker run \
        -v ${PWD}:/ws \
        bfren/alpine esh \
        "/ws/Dockerfile.esh" \
        BASE_REVISION=${BASE_REVISION} \
        ALPINE_REVISION=${ALPINE_REVISION}
    )

    echo "${DOCKERFILE}" > ./${V}/Dockerfile

done

echo "Done."

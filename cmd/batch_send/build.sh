#!/bin/bash
set -euo pipefail

rm -rf ./bin
mkdir -p ./bin

GIT_VERSION=$(cd ../ && git describe --tag --abbrev=0)
GIT_REVISION=$(cd ../ && git rev-list -1 HEAD)
GIT_BUILD=$(cd ../ && git describe --tags)

docker build -f ./Dockerfile.build . -t email-distributor-batch-send-builder-image \
    --build-arg GIT_VERSION=$GIT_VERSION --build-arg GIT_REVISION=$GIT_REVISION --build-arg GIT_BUILD=$GIT_BUILD
docker run --name email-distributor-batch-send-builder -d email-distributor-batch-send-builder-image
docker cp email-distributor-batch-send-builder:/app/batch-send ./bin/batch-send
docker stop email-distributor-batch-send-builder
docker rm email-distributor-batch-send-builder

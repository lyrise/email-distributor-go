#!/bin/bash
set -euo pipefail

rm -rf ./bin/api
mkdir -p ./bin/api

GIT_SEMVER=$(git describe --tags 2>/dev/null || echo "unknown")
GIT_SHA=$(git rev-parse HEAD)
BUILD_TIMESTAMP=$(date -Iseconds)

docker build -f ./Dockerfile.build.api . -t email-distributor-cmd-api-builder-image \
    --build-arg GIT_SEMVER=$GIT_SEMVER --build-arg GIT_SHA=$GIT_SHA
docker run --name email-distributor-cmd-api-builder -d email-distributor-cmd-api-builder-image
docker cp email-distributor-cmd-api-builder:/bin/api ./bin/api/email-distributor-api
docker stop email-distributor-cmd-api-builder && docker rm email-distributor-cmd-api-builder

#!/bin/bash
set -euo pipefail

rm -rf ./bin/batch
mkdir -p ./bin/batch

GIT_SEMVER=$(git describe --tags 2>/dev/null || echo "unknown")
GIT_SHA=$(git rev-parse HEAD)
BUILD_TIMESTAMP=$(date -Iseconds)

docker build -f ./Dockerfile.build.batch . -t email-distributor-cmd-batch-builder-image \
    --build-arg GIT_SEMVER=$GIT_SEMVER --build-arg GIT_SHA=$GIT_SHA --build-arg BUILD_TIMESTAMP=$BUILD_TIMESTAMP
docker run --name email-distributor-cmd-batch-builder -d email-distributor-cmd-batch-builder-image
docker cp email-distributor-cmd-batch-builder:/app/cmd/batch_send/email-distributor-batch-send ./bin/batch/email-distributor-batch-send
docker stop email-distributor-cmd-batch-builder && docker rm email-distributor-cmd-batch-builder

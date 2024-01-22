#!/bin/bash
set -euo pipefail

rm -rf ./bin/batch
mkdir -p ./bin/batch

GIT_SEMVER=$(git describe --tags 2>/dev/null || echo "unknown")
GIT_SHA=$(git rev-parse HEAD)
BUILD_TIMESTAMP=$(date -Iseconds)

docker build --platform linux/amd64 -f ./Dockerfile.build.batch . -t email-distributor-cmd-batch-builder-image \
    --build-arg GIT_SEMVER=$GIT_SEMVER --build-arg GIT_SHA=$GIT_SHA
docker run --name email-distributor-cmd-batch-builder -d email-distributor-cmd-batch-builder-image
docker cp email-distributor-cmd-batch-builder:/bin/batch-send ./bin/batch/email-distributor-batch-send
docker cp email-distributor-cmd-batch-builder:/bin/batch-send-feedback ./bin/batch/email-distributor-batch-send-feedback
docker stop email-distributor-cmd-batch-builder && docker rm email-distributor-cmd-batch-builder

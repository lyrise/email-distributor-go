#!/bin/bash
set -euo pipefail

./build.sh

AWS_REGION="us-east-1"
AWS_ACCOUNT_ID="470439311941"
LAMBDA_ARN="arn:aws:lambda:${AWS_REGION}:${AWS_ACCOUNT_ID}:email-distributor-batch-send"
DOCKER_IMAGE="${AWS_ACCOUNT_ID}.dkr.ecr.${AWS_REGION}.amazonaws.com/email-distributor-batch-send:latest"

aws ecr get-login-password --region ${AWS_REGION} | docker login --username AWS --password-stdin "${AWS_ACCOUNT_ID}.dkr.ecr.${AWS_REGION}.amazonaws.com"

if ! docker build -f "./Dockerfile.run" -t "${DOCKER_IMAGE}" --force-rm=true .; then
    echo "Failed to build docker image"
    exit 1
fi

docker push "${DOCKER_IMAGE}"

aws lambda update-function-code --function-name email-distributor-batch-send --image-uri ${DOCKER_IMAGE}

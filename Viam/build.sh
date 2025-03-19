#!/bin/bash

set -e

SCRIPT_DIR="$(cd "$(dirname "$0")" && pwd)"

source "${SCRIPT_DIR}/.env"
docker build --build-arg USERNAME=$USERNAME --build-arg BASE_IMAGE=$BASE_IMAGE_NAME -t "${IMAGE_NAME}" $SCRIPT_DIR

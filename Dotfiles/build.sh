#!/bin/bash

set -e

SCRIPT_DIR="$(cd "$(dirname "$0")" && pwd)"

source "${SCRIPT_DIR}/.env"
docker build --no-cache -t "${IMAGE_NAME}" $SCRIPT_DIR

#!/bin/bash

set -e

SCRIPT_DIR="$(cd "$(dirname "$0")" && pwd)"

source "${SCRIPT_DIR}/.env"

docker run --rm -v ~/Developer/Git/Github/Code/Viam:/home/$USERNAME/Developer/Git/Github/Code/Viam -it "${IMAGE_NAME}"

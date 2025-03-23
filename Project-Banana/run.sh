#!/bin/bash

set -e

SCRIPT_DIR="$(cd "$(dirname "$0")" && pwd)"

source "${SCRIPT_DIR}/.env"

# TODO: get agent forwarding to work

# eval "$(ssh-agent -s)"
# ssh-add ~/.ssh/id_ed25519

docker run -it --rm \
    --hostname=${HOSTNAME} \
    -v ~/Developer/Git/Github/Code/project-banana:/home/$USERNAME/Developer/Git/Github/Code/project-banana \
    -v ~/.ssh:/home/$USERNAME/.ssh "${IMAGE_NAME}"
    # --mount type=bind,src=/run/host-services/ssh-auth.sock,target=/run/host-services/ssh-auth.sock \
    # -e SSH_AUTH_SOCK="/run/host-services/ssh-auth.sock" \
    # "${IMAGE_NAME}"

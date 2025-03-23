#!/bin/bash

set -e

SCRIPT_DIR="$(cd "$(dirname "$0")" && pwd)"

DOTFILES_DIRNAME="dotfiles"
DOTFILES_SRC_DIR="${HOME}/Developer/Git/Github/Code/${DOTFILES_DIRNAME}"
DOTFILES_COPY_DIRNAME="${DOTFILES_DIRNAME}.copy"
DOTFILES_DEST_DIR="${SCRIPT_DIR}/${DOTFILES_COPY_DIRNAME}"

if [[ -e "${DOTFILES_DEST_DIR}" ]]; then
    rm -rf "${DOTFILES_DEST_DIR}"
fi

cp -r "${DOTFILES_SRC_DIR}" "${DOTFILES_DEST_DIR}"

source "${SCRIPT_DIR}/.env"
docker compose -f "${SCRIPT_DIR}/docker-compose.yaml" run --build --rm main

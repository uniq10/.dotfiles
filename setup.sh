#!/bin/sh

# Automatically exit if any of the subsequent commands fail.
set -e

# Find the directory path of setup.sh.
SCRIPT_DIR="$( cd -- "$( dirname -- "${0}" )" > /dev/null 2>&1 && pwd -P )"

. "${SCRIPT_DIR}/functions.sh"

if [ -e "${HOME}/.dotfilesrc" ]; then
    echo "Backing up old ${HOME}/.dotfilesrc"
    _suffix_mv "${HOME}/.dotfilesrc" "${SCRIPT_DIR}/backup"
fi

echo "DOTFILES_DIR=${SCRIPT_DIR}" > ${HOME}/.dotfilesrc

if _cmd_exists zsh; then
    "${SCRIPT_DIR}/zsh/setup.zsh"
fi

"${SCRIPT_DIR}/vim/setup.sh"

if _cmd_exists code; then
    "${SCRIPT_DIR}/vscodium/setup.sh"
fi

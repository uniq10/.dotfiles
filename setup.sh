#!/bin/sh

# Automatically exit if any of the subsequent commands fail.
set -e

# Find the directory path of setup.sh.
SCRIPT_DIR="$( cd -- "$( dirname -- "$0" )" > /dev/null 2>&1 && pwd -P )"
DOTFILES_DIR="$( cd -- "${HOME}/.dotfiles" > /dev/null 2>&1 && pwd -P )"
BACKUP_DIR="${SCRIPT_DIR}/backup"

. "${DOTFILES_DIR}/functions.sh"

# Only procced with installation if .dotfiles present in $HOME.
if [ ! $DOTFILES_DIR = $SCRIPT_DIR ]; then
    echo "setup.sh must be in ${DOTFILES_DIR}. Aborting."
    exit 1
fi

if _cmd_exists zsh; then
    "${DOTFILES_DIR}/zsh/setup.zsh"
fi

"${DOTFILES_DIR}/vim/setup.sh"

if _cmd_exists code; then
    "${DOTFILES_DIR}/vscodium/setup.sh"
fi

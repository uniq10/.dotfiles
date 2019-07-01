#!/usr/bin/env zsh

source "${HOME}/.dotfiles/functions.sh"

# Find the directory path of setup.zsh.
SCRIPT_DIR="$( cd -- "$( dirname -- "$0" )" > /dev/null 2>&1 && pwd -P )"
ZSHRC_PATH="${ZDOTDIR-${HOME}}/.zshrc"
    
echo "Setting up zsh."

if [ -e "${ZSHRC_PATH}" ]; then
    echo "Backing up old ${ZSHRC_PATH}"
    _suffix_mv ${ZSHRC_PATH} ${HOME}/.dotfiles/backup
fi

echo "Creating symlink to ${SCRIPT_DIR}/rc.zsh at ${ZSHRC_PATH}"
ln -fs -- "${SCRIPT_DIR}/rc.zsh" "${ZSHRC_PATH}"

# Install zplug.
echo "Attempting to install zplug."
"${SCRIPT_DIR}/zplug-installer.zsh" || true

echo "zsh setup done."

#!/usr/bin/env zsh

echo
echo "#############"
echo "# zsh setup #"
echo "#############"
echo

source "${HOME}/.dotfilesrc"
source "${DOTFILES_DIR}/functions.sh"

SCRIPT_DIR="${DOTFILES_DIR}/zsh"

ZSHRC_PATH="${ZDOTDIR-${HOME}}/.zshrc"

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
echo

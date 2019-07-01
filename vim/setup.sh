#!/bin/sh

# Automatically exit if any of the subsequent commands fail.
set -e

# Find the directory path of setup.sh.
SCRIPT_DIR="$( cd -- "$( dirname -- "$0" )" > /dev/null 2>&1 && pwd -P )"
BACKUP_DIR="${HOME}/.dotfiles/backup"

. ${HOME}/.dotfiles/functions.sh

echo "Setting up vim/nvim."

# vim setup
if [ -e "${HOME}/.vimrc" ]; then
    echo "Backing up old ${HOME}/.vimrc"
    _suffix_mv "${HOME}/.vimrc" "${BACKUP_DIR}"
fi

echo "Creating symlink to ${SCRIPT_DIR}/rc.vim at ${HOME}/.vimrc"
ln -fs -- "${SCRIPT_DIR}/rc.vim" "${HOME}/.vimrc"
echo ".vimrc symlink created."

if [ -e "${HOME}/.vim" ] && \
   [ "$(cd -- "${HOME}/.vim" > /dev/null 2>&1 && pwd -P )" = "${SCRIPT_DIR}" ]; then
    echo "${HOME}/.vim same as script directory."
    echo ".vim symlink not required."
else
    if [ -e "${HOME}/.vim" ]; then
        echo "Backing up ${HOME}/.vim"
        _suffix_mv "${HOME}/.vim" "${BACKUP_DIR}"
    fi
    echo "Creating symlink to ${SCRIPT_DIR} at ${HOME}/.vim"
    ln -fs -- "${SCRIPT_DIR}" "${HOME}/.vim"
    echo ".vim symlink created."
fi

# nvim setup
if [ ! -z "${XDG_CONFIG_HOME}" ]; then
    if [ ! -e "${XDG_CONFIG_HOME}" ]; then
        mkdir -p -- "${XDG_CONFIG_HOME}"
    fi
    NVIM_DIR="${XDG_CONFIG_HOME}/nvim"
else
    if [ ! -e "${HOME}/.config" ]; then
        mkdir -p -- "${HOME}/.config"
    fi
    NVIM_DIR="${HOME}/.config/nvim"
fi

if [ -e "${NVIM_DIR}" ]; then
    echo "Backing up ${NVIM_DIR}"
    _suffix_mv "${NVIM_DIR}" "${BACKUP_DIR}"
fi

echo "Creating symlink to ${SCRIPT_DIR}/nvim at ${NVIM_DIR}"
ln -fs -- "${SCRIPT_DIR}/nvim" "${NVIM_DIR}"
echo "nvim directory symlink created."


echo "Attempting to install plugins."

{ vim +PlugUpgrade +PlugUpdate +qall && echo "Plugins installed for Vim."; } \
    || { echo "Automatic plugin installation failed for Vim."; \
         echo "Open Vim and execute ':PlugUpgrade' and ':PlugUpdate'" \
              "for manual installation."; }

{ nvim +PlugUpgrade +PlugUpdate +qall && echo "Plugins installed for nvim."; } \
    || { echo "Automatic plugin installation failed for nvim."; \
         echo "Open nvim and execute ':PlugUpgrade' and ':PlugUpdate'" \
              "for manual installation."; }

echo "vim/nvim setup done."

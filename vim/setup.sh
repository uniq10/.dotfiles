#!/bin/sh

# Automatically exit if any of the subsequent commands fail.
set -e

echo
echo "##################"
echo "# vim/nvim setup #"
echo "##################"
echo

. "${HOME}/.dotfilesrc"
. "${DOTFILES_DIR}/functions.sh"

SCRIPT_DIR="${DOTFILES_DIR}/vim"
BACKUP_DIR="${DOTFILES_DIR}/backup"

# vim setup
if [ -e "${HOME}/.vimrc" ]; then
    echo "Backing up old ${HOME}/.vimrc"
    _suffix_mv "${HOME}/.vimrc" "${BACKUP_DIR}"
fi

echo "Creating symlink to ${SCRIPT_DIR}/rc.vim at ${HOME}/.vimrc"
ln -fs -- "${SCRIPT_DIR}/rc.vim" "${HOME}/.vimrc"
echo ".vimrc symlink created."

if [ -e "${HOME}/.vim" ]; then
    echo "Backing up ${HOME}/.vim"
    _suffix_mv "${HOME}/.vim" "${BACKUP_DIR}"
fi

echo "Creating symlink to ${SCRIPT_DIR} at ${HOME}/.vim"
ln -fs -- "${SCRIPT_DIR}" "${HOME}/.vim"
echo ".vim symlink created."


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
echo

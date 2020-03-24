#!/bin/sh

# Automatically exit if any of the subsequent commands fail.
set -e

# Find the directory path of setup.sh.
SCRIPT_DIR="$( cd -- "$( dirname -- "$0" )" > /dev/null 2>&1 && pwd -P )"
BACKUP_DIR="${HOME}/.dotfiles/backup"

. ${HOME}/.dotfiles/functions.sh
. ${HOME}/.dotfiles/platform/platform_pre.sh

echo "Setting up VSCodium."

SETTINGS_FILE="${VSCODIUM_CONFIG_DIR}/settings.json"
if [ -e "${SETTINGS_FILE}" ]; then
    echo "Backing up old ${SETTINGS_FILE}"
    _suffix_mv "${SETTINGS_FILE}" "${BACKUP_DIR}"
fi

echo "Creating symlink to ${SCRIPT_DIR}/settings.json at ${SETTINGS_FILE}"
ln -fs -- "${SCRIPT_DIR}/settings.json" "${SETTINGS_FILE}"
echo "settings.json symlink created."

KEYBINDINGS_FILE="${VSCODIUM_CONFIG_DIR}/keybindings.json"
if [ -e "${KEYBINDINGS_FILE}" ]; then
    echo "Backing up old ${KEYBINDINGS_FILE}"
    _suffix_mv "${KEYBINDINGS_FILE}" "${BACKUP_DIR}"
fi

echo "Creating symlink to ${SCRIPT_DIR}/keybindings.json at ${KEYBINDINGS_FILE}"
ln -fs -- "${SCRIPT_DIR}/keybindings.json" "${KEYBINDINGS_FILE}"
echo "keybindings.json symlink created."

echo "Installing extensions."
xargs -L 1 code --install-extension < "${SCRIPT_DIR}/extensions.list"

echo "VSCodium setup done."

#!/bin/sh

set -e

echo
echo "###################"
echo "# Miniconda setup #"
echo "###################"
echo

. "${HOME}/.dotfilesrc"
. "${DOTFILES_DIR}/functions.sh"
. "${DOTFILES_DIR}/platform/platform_pre.sh"

if [ -d "${MINICONDA_DIR}" ]; then
    echo "Seems links miniconda already installed at ${MINICONDA_DIR}. Skipping."
    exit 0
fi

INSTAL_SCRIPT="${DOTFILES_DIR}/scratch/${_MINICONDA_INSTAL_SCRIPT##*/}"

if ! _cmd_exists curl; then
    echo "curl not found. Cannot download miniconda. Aborting."
    exit 1
fi

curl "${_MINICONDA_INSTAL_SCRIPT}" -o "${INSTAL_SCRIPT}"
chmod u+x ${INSTAL_SCRIPT}

eval "${INSTAL_SCRIPT}" -p "${MINICONDA_DIR}" -s -b

echo "miniconda setup done."
echo

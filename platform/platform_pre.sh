. "${HOME}/.dotfilesrc"

MINICONDA_DIR="${HOME}/.miniconda3"

case "$(uname -s)" in

   Darwin)
     . "${DOTFILES_DIR}/platform/mac_pre.sh"
     ;;

   Linux)
     . "${DOTFILES_DIR}/platform/linux_pre.sh"
     ;;

esac

_MINICONDA_INSTAL_SCRIPT="https://repo.anaconda.com/miniconda/Miniconda3-latest-\
${_MINICONDA_INSTAL_SCRIPT_SUFFIX}"

. "${HOME}/.dotfilesrc"

case "$(uname -s)" in

   Darwin)
     . "${DOTFILES_DIR}/platform/mac_pre.sh"
     ;;

   Linux)
     . "${DOTFILES_DIR}/platform/linux_pre.sh"
     ;;

esac

DOTFILES_DIR="$HOME/.dotfiles"
PLATFORM_DIR="${DOTFILES_DIR}/platform"

case "$(uname -s)" in

   Darwin)
     . "${PLATFORM_DIR}/mac_pre.sh"
     ;;

   Linux)
     . "${PLATFORM_DIR}/linux_pre.sh"
     ;;

esac

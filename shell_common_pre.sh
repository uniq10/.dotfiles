. "${HOME}/.dotfiles/functions.sh"

PATH="${HOME}/.bin"${PATH:+:${PATH}}

# If available use nvim instead of vim.
if _cmd_exists nvim; then
    alias vim="nvim"
fi

# If available use vim as EDITOR.
EDITOR_BIN=vi
if _cmd_exists "$vim_bin"; then
    EDITOR_BIN="$vim_bin"
    export EDITOR="vim"
    export VISUAL="vim"
fi

# Add platform specific configurations.
. "${HOME}/.dotfiles/platform/platform_pre.sh"

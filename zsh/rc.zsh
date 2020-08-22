source "${HOME}/.dotfilesrc"
source "${DOTFILES_DIR}/shell_common_pre.sh"

# Use Vim keybindings.
bindkey -v
bindkey "jj" vi-cmd-mode

# Disable CR before prompt.
setopt no_prompt_cr

# Use zplug for plugin management.
source "${HOME}/.zplug/init.zsh"

# Setup theme.
zplug "agkozak/agkozak-zsh-prompt"
AGKOZAK_BLANK_LINES=1
AGKOZAK_PROMPT_CHAR=( $ %# : )
AGKOZAK_COLORS_PROMPT_CHAR="magenta"

zplug "zsh-users/zsh-autosuggestions"
zplug "zdharma/fast-syntax-highlighting"
zplug "plugins/colored-man-pages", from:oh-my-zsh
zplug "lib/history", from:oh-my-zsh

# Install plugins if there are plugins that have not been installed.
if ! zplug check; then
    zplug check --verbose
    printf "Install? [y/N]: "
    if read -q; then
        echo; zplug install
    fi
fi

# Source plugins and add commands to $PATH.
zplug load

# Enable kubectl completion.
if (( $+commands[kubectl] )); then
    __KUBECTL_COMPLETION_FILE="${ZSH_CACHE_DIR}/kubectl_completion"

    if [[ ! -f "${__KUBECTL_COMPLETION_FILE}" ]]; then
        kubectl completion zsh >! "${__KUBECTL_COMPLETION_FILE}"
    fi

    [[ -f "${__KUBECTL_COMPLETION_FILE}" ]] && source "${__KUBECTL_COMPLETION_FILE}"

    unset __KUBECTL_COMPLETION_FILE
fi

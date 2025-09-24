# Uncomment the following line to enable profiling (time taken by each command)
# You also need to uncomment the last line : zprof
# zmodload zsh/zprof

# ~/.zshrc
eval "$(starship init zsh)"
eval "$(zoxide init zsh)"

# Default terminal
export EDITOR=nvim

# Enable VIM mode
bindkey -v

# Aliases
alias node='unalias node ; unalias npm ; nvm use default ; node $@'
alias npm='unalias node ; unalias npm ; nvm use default ; npm $@'
alias n='nvim'
alias cd='z'

# NVM
export NVM_DIR="$HOME/.nvm" # https://github.com/nvm-sh/nvm/issues/539#issuecomment-245791291
[ -s "$NVM_DIR/nvm.sh" ] && . "$NVM_DIR/nvm.sh" --no-use # This loads nvm

# ZSH Plugins
source /opt/homebrew/share/zsh-syntax-highlighting/zsh-syntax-highlighting.zsh
source /opt/homebrew/share/zsh-autosuggestions/zsh-autosuggestions.zsh

# FZF
source <(fzf --zsh)
export FZF_DEFAULT_OPTS="--preview 'bat --color=always {}'"

# Optimize completion loading
autoload -Uz compinit
if [ "$(date +'%j')" != "$(stat -f '%Sm' -t '%j' ~/.zcompdump 2>/dev/null)" ]; then
    compinit
else
    compinit -C
fi

# The following lines have been added by Docker Desktop to enable Docker CLI completions.
fpath=(/Users/frederickbeaulieu/.docker/completions $fpath)
autoload -Uz compinit
compinit

## Yazi
function y() {
  local tmp="$(mktemp -t "yazi-cwd.XXXXXX")" cwd
  yazi "$@" --cwd-file="$tmp"
  if cwd="$(command cat -- "$tmp")" && [ -n "$cwd" ] && [ "$cwd" != "$PWD" ]; then
    builtin cd -- "$cwd"
  fi
  rm -f -- "$tmp"
}

# Uncomment the following line to enable profiling (time taken by each command)
# zprof

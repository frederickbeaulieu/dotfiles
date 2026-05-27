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
export PATH="$(nvm which default | xargs dirname):$PATH"

#GCloud 
export PATH=/opt/homebrew/share/google-cloud-sdk/bin:"$PATH"

#Dart
export PATH="$PATH":"$HOME/.pub-cache/bin"

#Android dev tools
export PATH="$HOME/Library/Android/sdk/platform-tools:$PATH"

# Golang
export GOPATH="$HOME/go"
export PATH="$PATH:$GOPATH/bin"

# ZSH Plugins
source /opt/homebrew/share/zsh-autosuggestions/zsh-autosuggestions.zsh
source /opt/homebrew/share/zsh-autocomplete/zsh-autocomplete.plugin.zsh

# FZF
source <(fzf --zsh)
export FZF_DEFAULT_OPTS="--preview 'bat --color=always {}'"

# syntax-highlighting must be sourced last
source /opt/homebrew/share/zsh-syntax-highlighting/zsh-syntax-highlighting.zsh

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

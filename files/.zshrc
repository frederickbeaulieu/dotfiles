# Uncomment the following line to enable profiling (time taken by each command)
# You also need to uncomment the last line : zprof
# zmodload zsh/zprof

# ~/.zshrc
eval "$(starship init zsh)"
eval "$(zoxide init zsh)"

# Default terminal
export EDITOR=nvim

# JAVA
export JAVA_HOME=$(/usr/libexec/java_home -v 17)
export PATH=$JAVA_HOME/bin:$PATH
export PATH="/opt/homebrew/opt/openjdk@17/bin:$PATH"
export CPPFLAGS="-I/opt/homebrew/opt/openjdk@17/include"

### BEGIN setantenv.sh
export PLATFORM_HOME
PLATFORM_HOME=~/cloud-commerce/core-customize/hybris/bin/platform/

if [ -z "${ANT_MEM_OPTS}" ]; then
  MEM_OPTS='-Xmx2G'
else
  MEM_OPTS="${ANT_MEM_OPTS}"
fi
export ANT_OPTS="$MEM_OPTS -Dfile.encoding=UTF-8 -Dpolyglot.js.nashorn-compat=true -Dpolyglot.engine.WarnInterpreterOnly=false \
--add-exports java.xml/com.sun.org.apache.xpath.internal=ALL-UNNAMED \
--add-exports java.xml/com.sun.org.apache.xpath.internal.objects=ALL-UNNAMED"
export ANT_HOME="$PLATFORM_HOME/apache-ant"
chmod +x "$ANT_HOME/bin/ant"
chmod +x "$PLATFORM_HOME/license.sh"
case "$PATH" in
*$ANT_HOME/bin:*) ;;
*) export PATH=$ANT_HOME/bin:$PATH ;;
esac
### END setantenv.sh

### Load the aliases
source /Users/frederickbeaulieu/.zsh_aliases

# NVM
# export NVM_DIR="$HOME/.nvm"
# [ -s "/opt/homebrew/opt/nvm/nvm.sh" ] && \. "/opt/homebrew/opt/nvm/nvm.sh"                                       # This loads nvm
export NVM_DIR="$HOME/.nvm" # https://github.com/nvm-sh/nvm/issues/539#issuecomment-245791291
[ -s "$NVM_DIR/nvm.sh" ] && . "$NVM_DIR/nvm.sh" --no-use # This loads nvm

alias node='unalias node ; unalias npm ; nvm use default ; node $@'
alias npm='unalias node ; unalias npm ; nvm use default ; npm $@'

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
# End of Docker CLI completions

## Yazi
function y() {
  local tmp="$(mktemp -t "yazi-cwd.XXXXXX")" cwd
  yazi "$@" --cwd-file="$tmp"
  if cwd="$(command cat -- "$tmp")" && [ -n "$cwd" ] && [ "$cwd" != "$PWD" ]; then
    builtin cd -- "$cwd"
  fi
  rm -f -- "$tmp"
}

## Startup screen
# screenfetch

# Enable VIM mode
bindkey -v

# Uncomment the following line to enable profiling (time taken by each command)
# zprof

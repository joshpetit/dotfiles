#if command -v tmux &> /dev/null && [ -n "$PS1" ] && [[ ! "$TERM" =~ screen ]] && [[ ! "$TERM" =~ tmux ]] && [ -z "$TMUX" ]; then
  #exec tmux
#fi
# History
setopt APPEND_HISTORY
HISTFILE="$HOME/.config/zsh/histfile"
HISTSIZE=2500
SAVEHIST=2500

#autoload -z edit-command-line
#bindkey "^X^E" edit-command-line

alias lnvm='source /usr/share/nvm/init-nvm.sh'

# Go
export GO111MODULE=auto

# Vim
# bindkey -v
export VISUAL=nvim
export EDITOR=/usr/bin/nvim

zstyle :compinstall filename "$HOME/.zshrc"
zstyle ':completion:*' rehash true
zstyle ':completion:*' menu select


# No Stupid beeps
unsetopt BEEP

alias e=exit

autoload -Uz compinit
compinit
# End of lines added by compinstall
#
if [ -x /usr/bin/dircolors ]; then
  test -r ~/.dircolors && eval "$(dircolors -b ~/.dircolors)" || eval "$(dircolors -b)"
  alias ls='ls --color=auto'
fi
setxkbmap -option caps:swapescape

alias ll='ls -alF'
alias la='ls -A'
alias l='ls -CF'

# Prompt

PROMPT="%B%F{147}[->%f%b%d%B%F{147}]%f%b "

if type rg &>/dev/null; then
  export FZF_DEFAULT_COMMAND='rg --files --hidden'
  export FZF_DEFAULT_OPTS='-m --height 50% --border'
fi

# Zplug
source "$HOME/.config/zsh/zplug/init.zsh"

zplug "zsh-users/zsh-history-substring-search"

# c-N to search back in history c-P to search forward (swapped for convenience)
bindkey '^p' history-substring-search-down
bindkey '^n' history-substring-search-up
zplug load


# pip zsh completion start
function _pip_completion {
  local words cword
  read -Ac words
  read -cn cword
  reply=( $( COMP_WORDS="$words[*]" \
    COMP_CWORD=$(( cword-1 )) \
    PIP_AUTO_COMPLETE=1 $words[1] 2>/dev/null ))
  }
compctl -K _pip_completion pip
# pip zsh completion end

#pipenv zsh completion start
_pipenv() {
  eval $(env COMMANDLINE="${words[1,$CURRENT]}" _PIPENV_COMPLETE=complete-zsh  pipenv)
}
if [[ "$(basename -- ${(%):-%x})" != "_pipenv" ]]; then
  compdef _pipenv pipenv
fi
# end

#. /opt/asdf-vm/asdf.sh
alias lasdf="source /opt/asdf-vm/asdf.sh"

autoload -U +X bashcompinit && bashcompinit
#autoload bashcompinit && bashcompinit source /etc/bash_completion.d/azure-cli
source /etc/bash_completion.d/azure-cli

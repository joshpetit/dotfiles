#if command -v tmux &> /dev/null && [ -n "$PS1" ] && [[ ! "$TERM" =~ screen ]] && [[ ! "$TERM" =~ tmux ]] && [ -z "$TMUX" ]; then
  #exec tmux
#fi
# History
setopt APPEND_HISTORY
HISTFILE="$HOME/.config/zsh/histfile"
HISTSIZE=2500
SAVEHIST=2500
alias restartmouse='sudo modprobe -r psmouse && sudo modprobe psmouse'
alias ssh="TERM=xterm-256color ssh"

#autoload -z edit-command-line
#bindkey "^X^E" edit-command-line
#git
alias gpo='git push -u origin HEAD'
alias gcnb='git checkout -b '
alias gcb='git checkout '
alias gpl='git pull'
alias gcl='git checkout -'
alias src='source ~/.zshrc'
alias envim='pushd ~/.config/nvim && nvim && popd'
alias eorg='pushd ~/sync/org/ && nvim && popd'
alias dropdownt='alacritty --class dropdownt,dropdownt -e tmux & disown'

alias lnvm='source /usr/share/nvm/init-nvm.sh'
alias lnvmx='source /usr/share/nvm/init-nvm.sh && nvm use'
alias n='nvim'
alias nvims='nvim -S Session.vim'
alias cleanup='pacman -Rs $(pacman -Qtdq)'
alias shp='ssh my.phone -p 8022'
alias zathura='zathura --fork'
alias connect_speaker='bluetoothctl power on && bluetoothctl connect 04:21:44:C4:0F:8E'
alias connect_headphones='bluetoothctl power on && bluetoothctl connect 74:45:CE:46:CD:31'
# Go
export GO111MODULE=auto
#export CHROME_EXECUTABLE="/bin/google-chrome-stable"

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
alias t=tmux

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
bindkey "^k" up-line-or-search
bindkey "^j" down-line-or-search
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
export MS5_STORE=8080
export MS5_AUTH=9099

bindkey  '^[[Z' reverse-menu-complete


alias git-line-stats="git ls-files | xargs -n1 git blame --line-porcelain | sed -n 's/^author //p' | sort -f | uniq -ic | sort -nr"

source ~/.zshenv
autoload -U +X bashcompinit && bashcompinit
# No Stupid beeps
unsetopt BEEP
autoload -Uz compinit
compinit
zstyle :compinstall filename "$HOME/.zshrc"
zstyle ':completion:*' rehash true
zstyle ':completion:*' menu select

bindkey  '^[[Z' reverse-menu-complete
setopt APPEND_HISTORY
HISTFILE="$HOME/.local/zsh/histfile"
HISTSIZE=2500
SAVEHIST=2500

alias ll='ls -alF'
alias la='ls -A'
alias l='ls -CF'
alias git-line-stats="git ls-files | xargs -n1 git blame --line-porcelain | sed -n 's/^author //p' | sort -f | uniq -ic | sort -nr"
alias restartmouse='sudo modprobe -r psmouse && sudo modprobe psmouse'
alias ssh="TERM=xterm-256color ssh"

alias e=exit
alias t=tmux

#autoload -z edit-command-line
#bindkey "^X^E" edit-command-line
#git
alias gpo='git push -u origin HEAD'
alias gcnb='git checkout -b '
alias gcb='git checkout '
alias gpl='git pull'
alias gcl='git checkout -'
alias src='source ~/.zshrc && source ~/.zshenv'
alias envim='pushd ~/.config/nvim && nvim && popd'
alias eorg='pushd ~/sync/org/ && nvim && popd'
alias nr='pushd ~/sync/org/ && nvim refile.org && popd'
alias dropdownt='alacritty --class dropdownt,dropdownt -e tmux & disown'
alias fixresjunk='xrandr --output DP-3 --mode 1920x1080'
alias setclip="xclip -selection c"
alias getclip="xclip -selection c -o"

alias fpg='flutter pub get'
alias lnvm='source /usr/share/nvm/init-nvm.sh'
alias lnvmx='source /usr/share/nvm/init-nvm.sh && nvm use'
alias n='nvim'
alias nvims='nvim -S Session.vim'
alias ns='nvim -S Session.vim'
alias cleanup='pacman -Rs $(pacman -Qtdq)'
alias shp='ssh my.phone -p 8022'
alias zathura='zathura --fork'
alias connect_speaker='bluetoothctl power on && bluetoothctl connect 04:21:44:C4:0F:8E'
alias connect_headphones='bluetoothctl power on && bluetoothctl connect 74:45:CE:46:CD:31'
alias disconnect_bt='bluetoothctl disconnect'
alias firestoredeleteall='firebase firestore:delete --all-collections'
# Go
export GO111MODULE=auto
#export CHROME_EXECUTABLE="/bin/google-chrome-stable"

# Vim
# bindkey -v
export VISUAL=nvim
export EDITOR=/usr/bin/nvim

# End of lines added by compinstall
#
if [ -x /usr/bin/dircolors ]; then
  test -r ~/.dircolors && eval "$(dircolors -b ~/.dircolors)" || eval "$(dircolors -b)"
  alias ls='ls --color=auto'
fi

if type setxkbmap &>/dev/null; then
    setxkbmap -option caps:swapescape
fi

PROMPT="%B%F{137}[->%f%b%d%B%F{137}]%f%b "

if type rg &>/dev/null; then
  export FZF_DEFAULT_COMMAND='rg --files --hidden'
  export FZF_DEFAULT_OPTS='-m --height 50% --border'
fi

# Zplug
source $ZPLUG_FILE

zplug "zsh-users/zsh-history-substring-search"
# c-N to search back in history c-P to search forward (swapped for convenience)
bindkey '^p' history-substring-search-down
bindkey '^n' history-substring-search-up
bindkey "^k" up-line-or-search
bindkey "^j" down-line-or-search


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

# Host specific configurations
if [ -f ~/.zshextra ]; then
    source ~/.zshextra
fi
zplug load

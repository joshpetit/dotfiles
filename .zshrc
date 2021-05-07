# History
setopt APPEND_HISTORY
HISTFILE=/home/joshu/.config/zsh/histfile
HISTSIZE=2500
SAVEHIST=2500

alias lnvm='source /usr/share/nvm/init-nvm.sh'

# Go
export GO111MODULE=auto

# Vim 
#bindkey -v
export VISUAL=nvim                 
export EDITOR=/usr/bin/nvim

zstyle :compinstall filename '/home/joshu/.zshrc'
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
source /home/joshu/.config/zsh/zplug/init.zsh


zplug "zsh-users/zsh-history-substring-search"
zplug "arialdomartini/oh-my-git"

# c-N to search back in history c-P to search forward (swapped for convenience)
bindkey '^p' history-substring-search-down
bindkey '^n' history-substring-search-up
zplug load

# Pip env completions aparently
export BASE_SHELL=$(basename $SHELL)

if [[ "$BASE_SHELL" == "zsh" ]] ; then
autoload bashcompinit && bashcompinit
fi

_pipenv-pipes_completions() {
COMPREPLY=($(compgen -W "$(pipes --_completion)" -- "${COMP_WORDS[1]}"))
}

complete -F _pipenv-pipes_completions pipes

eval "`pip completion --zsh`"

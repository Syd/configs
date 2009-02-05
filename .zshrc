HISTFILE=~/.histfile
HISTSIZE=1000
SAVEHIST=1000
autoload -Uz prompt colors vcs_info compinit
compinit
colors
setopt prompt_subst
zstyle ':vcs_info:*' formats '%s:%b '
zstyle ':vcs_info:*' enable git cvs svn hg bzr
zstyle ':completion:*' completer _complete _ignored
zstyle :compinstall filename '/home/temp/.zshrc'
bindkey -e

alias l='ls --color'
alias ls='ls --color --file-type'
alias ll='ls --color -lh'
alias lh='ls --color -sh'
alias la='ls --color -a'
alias free='free -m'
alias du='du -h -s'
alias e='vim'

bindkey '\e[1~' beginning-of-line
bindkey '\e[4~' end-of-line
bindkey '\e[3~' delete-char

setopt extended_glob

function title {
  if [[ $TERM == "screen" ]]; then
    # Use these two for GNU Screen:
    print -nR $'\033k'$1$'\033'\\\

    print -nR $'\033]0;'$2$'\a'
  elif [[ $TERM == "xterm" || $TERM == "rxvt" ]]; then
    # Use this one instead for XTerms:
    print -nR $'\033]0;'$*$'\a'
  fi
}
  
function preexec {
  emulate -L zsh
  local -a cmd; cmd=(${(z)1})
  title $cmd[1]:t "$cmd[2,-1]"
}


precmd() {

  psvar=()
  vcs_info
  [[ -n $vcs_info_msg_0_ ]] && psvar[1]="${(C)vcs_info_msg_0_}"
  title zsh "$PWD"
}

PROMPT="%(?..%F{red}%?%f:)%n%B@%b%U%m%u: "
RPROMPT="(%F{yellow}%~%f) %B%F{red}%1v%f%b"


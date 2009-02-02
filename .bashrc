# .bashrc

# If not running interactively, don't do anything.
[ -z "$PS1" ] && return

# Ignore duplicate lines and always append history.
export HISTCONTROL=ignoreboth
shopt -s histappend
shopt -s checkwinsize

PATH=${PATH}:${HOME}/local/bin

export PS1="\[\033[01;30m\][\t][\w]\n\[\033[01;32m\]\u@\h\[\033[01;34m\] \$\[\033[00m\] "
export EDITOR=vim

# Aliases.
alias j='jobs -l'
alias ls='ls -F --color=auto'
alias l='ls -alF'
alias mv='mv -i'
alias rm='rm -i'
alias cp='cp -ip'
alias e='gvim'
alias grep='grep --color'
alias dv='setxkbmap dvorak'
alias gith='git --git-dir=.githome'

function micros() {
  python -c "import datetime; print datetime.datetime.fromtimestamp($1/1000000)"
}

function millis() {
  python -c "import datetime; print datetime.datetime.fromtimestamp($1/1000)"
}

function epoch() {
  date -d "$1" +%s
}

if [ -f ${HOME}/.bashrc.extra ]; then
  . ${HOME}/.bashrc.extra
fi

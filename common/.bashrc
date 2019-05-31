# .bashrc

PATH=${HOME}/bin:${PATH}

# If not running interactively, don't do anything.
[ -z "$PS1" ] && return

# Ignore duplicate lines and always append history.
export HISTCONTROL=ignoreboth
shopt -s histappend
shopt -s checkwinsize

export PROMPT_COMMAND="history -a"
export PS1="\[\033[01;30m\][\t][\w]\n\[\033[01;32m\]\u@\h\[\033[01;34m\] \$\[\033[00m\] "
export EDITOR=vim

# Aliases.
alias j='jobs -l'
alias l='ls -alF'
alias mv='mv -i'
alias rm='rm -i'
alias cp='cp -ip'
alias grep='grep --color'

alias kus='setxkbmap us'
alias kfr='setxkbmap ca,fr'
alias dv='setxkbmap dvorak'

if [[ ${DISPLAY} == "" ]]; then
  alias e='vim'
else
  alias e='gvim'
fi

if [[ $(uname) == "Darwin" ]]; then
  alias ls='ls -FG'
else
  alias ls='ls -F --color'
fi

function micros() {
  python -c "import datetime; print datetime.datetime.fromtimestamp($1/1000000)"
}

function millis() {
  python -c "import datetime; print datetime.datetime.fromtimestamp($1/1000)"
}

function epoch() {
  date -d "$1" +%s
}

function gd() {
  godoc $* | less
}

function dns2ip() {
    dig +short $* | sed "/[^0-9\.]/d" # use sed to remove non-IPv4 line e.g. alias
}

[ ! -f ~/.bashrc.local ] || source ~/.bashrc.local

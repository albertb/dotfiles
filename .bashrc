# .bashrc

# If not running interactively, don't do anything.
[ -z "$PS1" ] && return

# Ignore duplicate lines and always append history.
export HISTCONTROL=ignoreboth
shopt -s histappend
shopt -s checkwinsize

PATH=${PATH}:${HOME}/bin:${HOME}/local/bin

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

function micros() {
  python -c "import datetime; print datetime.datetime.fromtimestamp($1/1000000)"
}

function millis() {
  python -c "import datetime; print datetime.datetime.fromtimestamp($1/1000)"
}

function epoch() {
  date -d "$1" +%s
}

# Set default printer on googleedu*.corp.google.com workstations
#  in Cairo conference room in Mountain View for new hire orientation

if [ `echo $HOSTNAME | cut -c 1-9` = "googleedu" ]
then
  export PRINTER=hpcairo
  export LPDEST=$PRINTER
fi 

export GOOGLE_USE_CORP_SSL_AGENT=true
export GFS_CLIENT_SECURITY_LEVEL=integrity

export MOZ_DISABLE_PANGO=1
export MOZ_NO_REMOTE=1

alias fu="fileutil"
alias h="ssh -Y bistro.sfo"
alias he="h eclipse 2>&1>/dev/null &"
alias borgmon="/home/build/static/projects/borgmon/borgmon"
alias prober="/home/build/static/projects/borgmon/prober"
alias borgalert="/home/build/static/projects/borgmon/borgalert"
alias borgmon-eval="/home/build/static/projects/borgmon/borgmon-eval.par"
alias gaia="/home/build/static/projects/gaia/gaiaclient/GaiaClient.par"
alias smartsync="/home/build/nonconf/google3/tools/continuous_build/smartsync.sh"
alias szl="/home/build/static/projects/logs/szl"
alias saw="/home/build/static/projects/logs/saw"
alias findr="/home/build/google3/devtools/find_reviewers/find_reviewers.py"

export P4CONFIG=.p4config
#export P4DIFF="/home/build/public/google/tools/p4diff"
export P4DIFF="~/bin/proxyp4diff"
export P4MERGE=/home/build/public/eng/perforce/mergep4.tcl
export P4EDITOR="gvim -f"

alias startvnc="x11vnc -display :0 -auth /tmp/.gdm??????"

function runmr() {
borgcfg \
 /home/build/google3/production/borg/templates/java/mapreduce/mapreduce.borg \
 $3 \
 -vars="usegooglefile=true, cell=$1, user=$USER, \
        jar=$2, \
        sharedlib=`echo $2 | sed -e 's/_deploy\.jar/_swigdeps\.so/'`, \
        javavmargs='-Xmx512m', \
        jargs='', \
        jobname=albertb-`basename $2 _deploy.jar`-mr"
}

function killcl() {
  P4CLIENT=`p4 describe -s $1 | head -1 | awk '{ print $4; }' | sed 's/.*@//g'`
  g4 revert -c $1
}

source /home/build/google3/devtools/blaze/scripts/blaze-complete.bash
complete -C/home/build/static/projects/filecomplete fileutil codex fu

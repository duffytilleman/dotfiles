# ~/.bashrc: executed by bash(1) for non-login shells.

# If not running interactively, don't do anything
[ -z "$PS1" ] && return

# source everything from .bashrc.d
for f in $(dirname $BASH_SOURCE)/.bashrc.d/*; do source $f; done

# don't put duplicate lines in the history. See bash(1) for more options
# ... or force ignoredups and ignorespace
HISTCONTROL=ignoredups:ignorespace

# append to the history file, don't overwrite it
shopt -s histappend

# for setting history length see HISTSIZE and HISTFILESIZE in bash(1)
HISTSIZE=100000
HISTFILESIZE=200000

# check the window size after each command and, if necessary,
# update the values of LINES and COLUMNS.
shopt -s checkwinsize

# make less more friendly for non-text input files, see lesspipe(1)
[ -x /usr/bin/lesspipe ] && eval "$(SHELL=/bin/sh lesspipe)"

# set variable identifying the chroot you work in (used in the prompt below)
if [ -z "$debian_chroot" ] && [ -r /etc/debian_chroot ]; then
    debian_chroot=$(cat /etc/debian_chroot)
fi

# enable programmable completion features (you don't need to enable
# this, if it's already enabled in /etc/bash.bashrc and /etc/profile
# sources /etc/bash.bashrc).
if [ -f /etc/bash_completion ] && ! shopt -oq posix; then
    . /etc/bash_completion
fi
if [ -f /usr/local/git/contrib/completion/git-completion.bash ]; then
  source /usr/local/git/contrib/completion/git-completion.bash
  source /usr/local/git/contrib/completion/git-prompt.sh
fi
if [ -f /Library/Developer/CommandLineTools/usr/share/git-core/git-completion.bash ]; then
  source /Library/Developer/CommandLineTools/usr/share/git-core/git-completion.bash
  source /Library/Developer/CommandLineTools/usr/share/git-core/git-prompt.sh
fi
if [ -f /usr/local/Cellar/git/2.2.1/etc/bash_completion.d/git-completion.bash ]; then
  source /usr/local/Cellar/git/2.2.1/etc/bash_completion.d/git-completion.bash
  source /usr/local/Cellar/git/2.2.1/etc/bash_completion.d/git-prompt.sh
fi

export EDITOR=vi

stty -ixon #disable ctrl+s locking

function npm-homepage {
  URL=$(npm view $1 homepage | head -n 1)
  echo "Homepage URL: $URL"
  open $URL
}

function kill-interface {
  lsof -F p -s TCP:LISTEN -i $1 | sed s/p// | xargs kill
}

export PYTHONSTARTUP=~/.pythonrc

export TERM="xterm-256color"

export PLETHORA_GUID=c413115f97642651bb35a22c9d7e0dac 
export PLETHORA_API_KEY=jlLm7I2XsQ2qMpoRSeIzdW8xBVmwXeqVXj8cA9dehwO/UYOkXmSZrFP4J8BSEv6BeH4FbFBPju60IXfZQ0bFIQ== 
export PLETHORA_HOST=http://api.plethora.dev:3000 
export DAEMON_PID_DIR=$HOME/.daemons/

if ! ssh-add -L grep "$HOME/.ssh/id_rsa" > /dev/null; then
  ssh-add $HOME/.ssh/id_rsa > /dev/null
fi

if [ -f /usr/local/etc/profile.d/z.sh ]; then
  . /usr/local/etc/profile.d/z.sh
fi

export PATH=$PATH:$HOME/devops/bin

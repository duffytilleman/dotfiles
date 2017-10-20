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

# flush commands to history immediately
export PROMPT_COMMAND='history -a'

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
if [ -f $HOME/.git-completion.bash ]; then
  source $HOME/.git-completion.bash
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

for keyfile in id_rsa post_theft_id_rsa; do
  path=$HOME/.ssh/$keyfile
  if [[ -f "$path" ]]; then
    if ! ssh-add -L | grep "$path" > /dev/null; then
      ssh-add "$path" > /dev/null
    fi
  fi
done

if [ -f /usr/local/etc/profile.d/z.sh ]; then
  . /usr/local/etc/profile.d/z.sh
fi

gclouddir='/home/duffy/google-cloud-sdk'
if [[ -f $gclouddir ]]; then
  # The next line updates PATH for the Google Cloud SDK.
  source "$gclouddir/path.bash.inc"
  # The next line enables bash completion for gcloud.
  source "$gclouddir/completion.bash.inc"
fi


export NVM_DIR="/home/duffy/.nvm"
[ -s "$NVM_DIR/nvm.sh" ] && . "$NVM_DIR/nvm.sh"  # This loads nvm

export PLETHORA_HOME=$HOME

set +o noclobber

# FZF fuzzy file finder https://github.com/junegunn/fzf
if [ -f ~/.fzf.bash ]; then
  source ~/.fzf.bash
  bind -x '"\C-p": FILE=$(fzf) && vim "$FILE";'
fi

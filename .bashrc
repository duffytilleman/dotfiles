# ~/.bashrc: executed by bash(1) for non-login shells.

# If not running interactively, don't do anything
[ -z "$PS1" ] && return

if [ "${BASH_VERSINFO[0]}" -lt 5 ]; then
  echo "##################################################################"
  echo "Bash is old, currently version $BASH_VERSION"
  echo "On OSX, see https://itnext.io/upgrading-bash-on-macos-7138bd1066ba"
  echo "##################################################################"
  echo
fi

# don't put duplicate lines in the history. See bash(1) for more options
# ... or force ignoredups and ignorespace
HISTCONTROL=ignoredups:ignorespace

# append to the history file, don't overwrite it
shopt -s histappend

# for setting history length see HISTSIZE and HISTFILESIZE in bash(1)
export HISTSIZE=100000
export HISTFILESIZE=200000
export HISTIGNORE="ls:cd *:gl:gs:history"
# export HISTTIMEFORMAT="%s "

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
if ! shopt -oq posix; then
  if [ -f /etc/bash_completion ]; then  # debian
    . /etc/bash_completion
  elif [[ -r "/usr/local/etc/profile.d/bash_completion.sh" ]]; then # mac os homebrew
    . "/usr/local/etc/profile.d/bash_completion.sh"
  elif [[ -r "/opt/homebrew/etc/profile.d/bash_completion.sh" ]]; then # mac os homebrew, new location
      . "/opt/homebrew/etc/profile.d/bash_completion.sh"
  elif [ -f /usr/local/etc/bash_completion ]; then
    . /usr/local/etc/bash_completion
  fi
fi

# if [ -f $HOME/.git-completion.bash ]; then
#   source $HOME/.git-completion.bash
# elif [ -f /usr/local/git/contrib/completion/git-completion.bash ]; then
#   source /usr/local/git/contrib/completion/git-completion.bash
#   source /usr/local/git/contrib/completion/git-prompt.sh
# elif [ -f /Library/Developer/CommandLineTools/usr/share/git-core/git-completion.bash ]; then
#   source /Library/Developer/CommandLineTools/usr/share/git-core/git-completion.bash
#   source /Library/Developer/CommandLineTools/usr/share/git-core/git-prompt.sh
# elif [ -f /usr/local/Cellar/git/2.2.1/etc/bash_completion.d/git-completion.bash ]; then
#   source /usr/local/Cellar/git/2.2.1/etc/bash_completion.d/git-completion.bash
#   source /usr/local/Cellar/git/2.2.1/etc/bash_completion.d/git-prompt.sh
# fi

export EDITOR=nvim

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
elif [ -f /opt/homebrew/etc/profile.d/z.sh ]; then
  . /opt/homebrew/etc/profile.d/z.sh
fi

gclouddir="$HOME/.google-cloud-sdk"
if [[ -d $gclouddir ]]; then
  # The next line updates PATH for the Google Cloud SDK.
  source "$gclouddir/path.bash.inc"
  # The next line enables bash completion for gcloud.
  source "$gclouddir/completion.bash.inc"
fi


export NVM_DIR="$HOME/.nvm"
[ -s "$NVM_DIR/nvm.sh" ] && . "$NVM_DIR/nvm.sh"  # This loads nvm

set +o noclobber

# FZF fuzzy file finder https://github.com/junegunn/fzf
if [ -f ~/.fzf.bash ]; then
  source ~/.fzf.bash
  bind -x '"\C-p": FILE=$(fzf) && vim "$FILE";'
fi


# Better tab completion behavior, from https://stackoverflow.com/a/48514114
# If there are multiple matches for completion, Tab should cycle through them

bind 'TAB':menu-complete
bind '"\t":menu-complete'

# Display a list of the matching files

bind "set show-all-if-ambiguous on"

# Perform partial completion on the first Tab press,
# only start cycling full results on the second Tab press

bind "set menu-complete-display-prefix on"

if command -v kubectl > /dev/null; then
  complete -F __start_kubectl k
  # source <(kubectl completion bash | set 's/kubectl/k/g/')
  source <(kubectl completion bash)
  # complete -F __start_kubectl kubectl
fi

# Load pyenv automatically by appending
if which -s pyenv; then
  eval "$(pyenv init -)"
fi

# Krew kubernetes plugin package manager
# export PATH="${KREW_ROOT:-$HOME/.krew}/bin:$PATH"

# From https://unix.stackexchange.com/a/4220
# example usage, for `alias apt-inst='apt-get install'`:
#  make-completion-wrapper _apt_get _apt_get_install apt-get install
#   complete -F _apt_get_install apt-inst
function make-completion-wrapper () {
  local function_name="$2"
  local arg_count=$(($#-3))
  local comp_function_name="$1"
  shift 2
  local function="
    function $function_name {
      ((COMP_CWORD+=$arg_count))
      COMP_WORDS=( "$@" \${COMP_WORDS[@]:1} )
      "$comp_function_name"
      return 0
    }"
  eval "$function"
}

make-and-apply-completion-wrapper() {
  local function_to_wrap="$1"
  local completion_function="$2"
  local wrapper_name="_$function_to_wrap"
  shift 2
  make-completion-wrapper "$completion_function" "$wrapper_name" $@
  complete -F "$wrapper_name" "$function_to_wrap"
}

make-and-apply-completion-wrapper git-combine-branches __git_wrap__git_main git checkout

# source everything from .bashrc.d
for f in $(dirname $BASH_SOURCE)/.bashrc.d/*; do source $f; done
unset f

# Something keeps overwriting this in $HOME/.gitconfig, so set it on each login
git config --global push.default simple

# # McFly history search https://github.com/cantino/mcfly
# export MCFLY_FUZZY=true
# export MCFLY_RESULTS=40
# export MCFLY_RESULTS_SORT=RANK # RANK, LAST_RUN
# eval "$(mcfly init bash)"

export BREW_NO_AUTO_UPDATE=1

export PATH=/Applications/SnowSQL.app/Contents/MacOS:$PATH
if [ -e /Users/duffy/.nix-profile/etc/profile.d/nix.sh ]; then . /Users/duffy/.nix-profile/etc/profile.d/nix.sh; fi # added by Nix installer

if [ $ITERM_SESSION_ID ]; then
  export PROMPT_COMMAND='terminal-title "${PWD##*/}"; '"$PROMPT_COMMAND";
fi

if [[ -f "/Users/duffy/.config/broot/launcher/bash/br" ]]; then
  source /Users/duffy/.config/broot/launcher/bash/br
fi

# Created by `pipx` on 2023-03-08 19:36:02
export PATH="$PATH:/Users/duffy/.local/bin"
eval "$(register-python-argcomplete pipx)"
[ -s "$NVM_DIR/bash_completion" ] && \. "$NVM_DIR/bash_completion"  # This loads nvm bash_completion

[[ -f ~/.bash-preexec.sh ]] && source ~/.bash-preexec.sh
eval "$(atuin init bash --disable-up-arrow)"

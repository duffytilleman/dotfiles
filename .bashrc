export LC_ALL=en_US.utf-8
export LANG="$LC_ALL"

#source $HOME/dotfiles/.bashrc

for f in $(dirname $BASH_SOURCE)/.bashrc.d/*; do source $f; done

#alias vi=vim
#export EDITOR=vim


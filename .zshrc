# The following lines were added by compinstall

zstyle ':completion:*' completer _complete _ignored _approximate
zstyle ':completion:*' matcher-list 'm:{[:lower:]}={[:upper:]}' 'l:|=* r:|=*'
zstyle :compinstall filename '/home/duffy/.zshrc'

autoload -Uz compinit
compinit
# End of lines added by compinstall

# Lines configured by zsh-newuser-install
HISTFILE=~/.histfile
HISTSIZE=50000
SAVEHIST=50000
unsetopt beep
bindkey -v
# End of lines configured by zsh-newuser-install

# Git prompt
source .zsh-git-prompt/zshrc.sh
PROMPT='%B%m%~%b$(git_super_status) %# '

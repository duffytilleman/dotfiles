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

# The next line updates PATH for the Google Cloud SDK.
if [ -f '/Users/duffy/Downloads/google-cloud-sdk/path.zsh.inc' ]; then . '/Users/duffy/Downloads/google-cloud-sdk/path.zsh.inc'; fi

# The next line enables shell command completion for gcloud.
if [ -f '/Users/duffy/Downloads/google-cloud-sdk/completion.zsh.inc' ]; then . '/Users/duffy/Downloads/google-cloud-sdk/completion.zsh.inc'; fi

# added by Snowflake SnowSQL installer v1.2
export PATH=/Applications/SnowSQL.app/Contents/MacOS:$PATH
if [ -e /Users/duffy/.nix-profile/etc/profile.d/nix.sh ]; then . /Users/duffy/.nix-profile/etc/profile.d/nix.sh; fi # added by Nix installer

source /Users/duffy/.config/broot/launcher/bash/br

eval "$(atuin init zsh)"

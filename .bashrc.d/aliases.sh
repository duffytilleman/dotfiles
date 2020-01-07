alias egrep='egrep --color=auto'

alias fgrep='fgrep --color=auto'
alias gitx='/Applications/GitX.app/Contents/Resources/gitx'
alias gp='git pull'
alias grep='grep --color=auto'
alias gs='git status'
alias gca='git commit --amend'
alias gc='git checkout'
alias gcm='git checkout master'
alias gri='git rebase --interactive'
alias l='ls -CF'
alias la='ls -A'
alias ll='ls -alF'
alias hr='heroku run'
alias hrs='heroku run --remote staging'
alias ..='cd ..'
alias ...='cd ../..'
alias ....='cd ../../..'
alias d='./docker/exec'
alias bell='echo '
alias ggf='git ls-files | grep'
alias rgf='rg --files | grep'

alias heorku=heroku
alias herkou=heroku
alias h=heroku

alias glcoud=gcloud
alias gc=gcloud
alias gci='gcloud compute instances'
alias gcs='gcloud compute ssh'

alias tma='tmux attach'

# Platform specific aliases
platform=`uname`
if [[ $platform == 'Linux' ]]; then
  alias ls='ls --color'
elif [[ $platform == 'Darwin' ]]; then
  alias ls='ls -G'
fi

alias git-merge-diff='git diff `git merge-base HEAD master`'

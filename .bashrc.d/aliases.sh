alias egrep='egrep --color=auto'

alias fgrep='fgrep --color=auto'
alias gp='git pull'
alias grep='grep --color=auto'
alias gs='git status' # Note, this shadows ghostscript
alias gca='git commit --amend -C HEAD'
alias gcam='git commit --amend'
alias gc='git checkout'
alias gsp='git stash pop'
alias gcm='git checkout master'
alias gri='git rebase --interactive'
alias ggf='git ls-files | grep'
alias glf='git log --all --'
alias glh='gl | head'
alias l='ls -CF'
alias la='ls -A'
alias ll='ls -alF'
alias ..='cd ..'
alias ...='cd ../..'
alias ....='cd ../../..'
alias bell='echo '
alias rgf='rg --files | grep'

alias glcoud=gcloud
alias gc=gcloud
alias gci='gcloud compute instances'
alias gcs='gcloud compute ssh'

alias tma='tmux attach || tmux'

alias vscode='open -a /Applications/Visual\ Studio\ Code.app/'

# Platform specific aliases
platform=`uname`
if [[ $platform == 'Linux' ]]; then
  alias ls='ls --color'
elif [[ $platform == 'Darwin' ]]; then
  alias ls='ls -G'
fi

alias git-merge-diff='git diff `git merge-base HEAD master`'
alias vdeploystatus='gcloud run services list --platform managed --format="table(name,metadata.generation,image,last_transition_time)"'
alias git-recent-untracked="git s | grep '^\t' | xargs ls -lt"
alias npm7=/usr/local/bin/npm
alias eb="exec bash -l"
alias isodate="date '+%Y-%m-%d_%H-%M-%S'"

complete -F _complete_alias "${!BASH_ALIASES[@]}"

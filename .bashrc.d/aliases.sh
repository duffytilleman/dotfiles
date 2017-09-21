alias egrep='egrep --color=auto'
alias fgrep='fgrep --color=auto'
alias gitx='/Applications/GitX.app/Contents/Resources/gitx'
alias gp='git pull'
alias grep='grep --color=auto'
alias gs='git status'
alias gca='git commit --amend'
alias gc='git checkout'
alias gcm='git checkout master'
alias l='ls -CF'
alias la='ls -A'
alias ll='ls -alF'
alias hr='heroku run'
alias hrs='heroku run --remote staging'
alias ..='cd ..'
alias ...='cd ../..'
alias ....='cd ../../..'
alias d='./docker/exec'

alias heorku=heroku
alias herkou=heroku
alias h=heroku

# Platform specific aliases
platform=`uname`
if [[ $platform == 'Linux' ]]; then
  alias ls='ls --color'
elif [[ $platform == 'Darwin' ]]; then
  alias ls='ls -G'
fi

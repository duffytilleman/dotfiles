# alias for starting or connecting to screen session
alias scr='TERM=screen-256color screen -dRRA'

alias hivegrep='grep -R --exclude=*.min.js --exclude-dir=lib --exclude-dir=.git --exclude-dir=.cache --exclude-dir=./libsrc/.webassets-cache, --exclude=*.log'

alias whatson='lsof -i'

? () { echo "$*" | bc -l; }

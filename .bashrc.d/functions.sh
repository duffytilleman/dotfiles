supa () {
  EXE=$1;
  shift;
  supervisor -e js,py,sh -n exit -x $EXE -- "$@"
}

latest () {
  if [ -d "$1" ]; then
    local res=$(ls -Art "$1" | tail -n 1);
    if [[ ! $1 =~ /$ ]]; then
      echo $1/$res
    fi
    echo $1$res;
  fi
}


psgrep() {
  if [[ "$1" = "-p" ]]; then
    shift;
    ps aux | grep -v grep | grep "$@" -i --color=auto | awk '{print $2}'
  else
    ps aux | grep -v grep | grep "$@" -i --color=auto
  fi
}

cdr() {
  # cd and tmux rename
  dir=$(readlink -f "$1")
  # TODO: finish
}

random-word() {
  shuf -n 1 /etc/dictionaries-common/words | sed "s/'s$//"
}

random-file() {
  BASE=$1
  FILE=$(ls $BASE | shuf -n 1)
  echo $BASE/$FILE
}

recent-branches() {
  N=${1:-20}
  git reflog | grep checkout | awk '!seen[$6]++ {print $6}' | head -n $N
}

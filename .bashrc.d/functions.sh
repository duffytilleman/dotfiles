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

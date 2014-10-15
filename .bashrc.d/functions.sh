supa () {
  EXE=$1;
  shift;
  supervisor -e py -n exit -x $EXE -- "$@"
}

latest () {
  if [ -d $1 ]; then
    local res=$(ls -Art $1 | tail -n 1);
    echo $1/$res;
  fi
}

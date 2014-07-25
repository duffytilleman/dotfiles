supa () {
  EXE=$1;
  shift;
  supervisor -e py -n exit -x $EXE -- "$@"
}

supa () {
  EXE=$1;
  shift;
  supervisor -n exit -x $EXE -- "$@"
}

#! /bin/bash

change-watch () {
  EXTENSIONS=`git ls-files | grep -o '\.[a-zA-Z0-9]\+$' | sort | uniq | sed 's/\.//' | tr '\n' ','`
  FILES=`git ls-files | tr '\n' ','`
  ROOTDIR=`pwd`
  SUPERVISOR=$ROOTDIR/node_modules/supervisor/lib/cli-wrapper.js

  echo "$FILES" | grep -o

  EXEC=$1
  shift

  $SUPERVISOR -q -e $EXTENSIONS -n exit -w "$FILES" -x $EXEC -- "$@"
}

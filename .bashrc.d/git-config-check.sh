CURRENT_DIR=$PWD

if which tempfile > /dev/null; then
  MYTMPDIR=`tempfile`
  rm $MYTMPDIR
else
  MYTMPDIR=$TMPDIR/git-config-check
fi

mkdir $MYTMPDIR

cd $MYTMPDIR
git init > /dev/null 2>&1
if [ $? -ne 0 ]
then
  git config --global push.default nothing
fi
cd $CURRENT_DIR
rm -rf $MYTMPDIR

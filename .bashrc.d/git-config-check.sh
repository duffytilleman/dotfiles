CURRENT_DIR=$PWD

TMPDIR=`tempfile`
rm $TMPDIR
mkdir $TMPDIR
cd $TMPDIR
git init > /dev/null 2>&1
if [ $? -ne 0 ]
then
  git config --global push.default nothing
fi
cd $CURRENT_DIR
rm -rf $TMPDIR

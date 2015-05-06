git-replace () {
  FILES=$(git grep -l "$1")
  echo $FILES
  sed -i -e "s/$1/$2/g" $FILES
  git clean -f *-e > /dev/null 2>&1
}

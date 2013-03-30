git-replace () {
  sed -i -e "s/$1/$2/g" $(git grep -l $1)
}
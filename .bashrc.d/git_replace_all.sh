git-replace () {
  # FILES=$(git grep -l "$1")
  # echo $FILES
  # sed -i -e "s/$1/$2/g" $FILES
  # git clean -f *-e > /dev/null 2>&1
  FILES=$(rg --multiline --files-with-matches "$1")
  for f in $FILES; do
    echo "$f"
    rg --multiline --passthru --no-line-number "$1" -r "$2" "$f" | sponge "$f"
  done
}

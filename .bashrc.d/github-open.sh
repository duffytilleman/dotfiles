github-open () {
  git remote -v | grep github | head -n 1 | sed -e "s/.*\@\(.*\).git.*/\1/" | sed "s/:/\//" | sed "s/^/http:\/\//" | xargs open
}

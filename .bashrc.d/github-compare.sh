github-compare () {
  REV1=$(git rev-parse $1)
  REV2=$(git rev-parse $2)
  BASE=$(git remote -v | grep origin | grep fetch | sed "s/.*git@\([^:]*\):\(.*\).git.*/\1\/\2/")
  open "https://$BASE/compare/$REV1...$REV2"
}

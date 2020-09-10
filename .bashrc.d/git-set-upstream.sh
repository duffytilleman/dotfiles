#!/bin/bash

git-set-upstream () {
  REV=`git rev-parse --abbrev-ref HEAD`
  if [[ -z $REV ]]; then
    echo 'Unknown branch'
    exit 1
  fi
  git branch --set-upstream-to=origin/$REV $REV
}

make-completion-wrapper __git_wrap__git_main _git_set_upstream git branch --set-upstream-to=origin/
complete -F _git_set_upstream git-set-upstream

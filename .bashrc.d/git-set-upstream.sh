#!/bin/bash

git-set-upstream () {
  REV=`git rev-parse --abbrev-ref HEAD`
  if [[ -z $REV ]]; then
    echo 'Unknown branch'
    exit 1
  fi
  git branch --set-upstream-to=origin/$REV $REV
}

#!/bin/bash

git-reset-safe() {
  if [[ -z $1 ]]; then
    echo "usage: git-reset-safe [REF]"
    return 1
  fi
  if ! (git diff > /dev/null 2>&1); then
    echo "Not a git repo"
    return 1
  fi
  if [[ "$1" == "--upstream" ]]; then
    target=$(git rev-parse --abbrev-ref --symbolic-full-name @{u})
  else
    target="$1"
  fi
  cached_changes=$(git diff --cached | wc -l | tr -d ' ')
  changes=$(git diff | wc -l | tr -d ' ')
  if [[ $cached_changes -gt 0 ]]; then
    echo -e 'Refusing reset, staged changes present\n'
    git status
    return 1
  fi
  if [[ $changes -gt 0 ]]; then
    echo -e 'Refusing reset, unstaged changes present\n'
    git status
    return 1
  fi

  echo git reset --hard $target
  git reset --hard $target
}

make-completion-wrapper __git_wrap__git_main _git_reset_safe git reset
complete -F _git_reset_safe git-reset-safe

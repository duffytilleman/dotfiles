#! /bin/bash

gl () {
  if [[ ! -d .git ]]; then
    echo "Not in a git directory"
    return 1
  fi

  mkdir -p .git/tag-backup
  mv .git/refs/tags/* .git/tag-backup
  git log --pretty="format:%Cred%h%Creset -%C(yellow)%d%Creset %s %Cgreen(%cr) %C(bold blue)<%an>%Creset"
  mv .git/tag-backup/* .git/refs/tags
}

gla () {
  if [[ ! -d .git ]]; then
    echo "Not in a git directory"
    return 1
  fi

  mkdir -p .git/tag-backup
  mv .git/refs/tags/* .git/tag-backup
  git log --pretty="format:%Cred%h%Creset -%C(yellow)%d%Creset %s %Cgreen(%cr) %C(bold blue)<%an>%Creset" --graph --all
  mv .git/tag-backup/* .git/refs/tags
}

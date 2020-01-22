#! /bin/bash

_git_log_pretty_format="format:%Cred%h%Creset -%C(yellow)%d%Creset %s %Cgreen(%cr) %C(bold blue)<%an>%Creset"

strip-git-tags () {
  sed 's/tag: [0-9.a-z-]\+,\? \?//g' | sed 's/ ()//' | less -R
}

gl () {
  git log --color --pretty="$_git_log_pretty_format" "$@" | strip-git-tags
}

gla () {
  git log --color --pretty="$_git_log_pretty_format" --graph --all | strip-git-tags
}

glm () {
  git log --color --pretty="$_git_log_pretty_format" --graph --branches master | strip-git-tags
}

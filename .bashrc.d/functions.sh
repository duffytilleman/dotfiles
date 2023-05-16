#!/bin/bash

supa () {
  EXE=$1;
  shift;
  supervisor -e js,py,sh -n exit -x $EXE -- "$@"
}

latest () {
  if [ -d "$1" ]; then
    local res=$(ls -Art "$1" | grep -v '^.git' | tail -n 1);
    if [[ ! $1 =~ /$ ]]; then
      echo $1/$res
    else
      echo $1$res;
    fi
  fi
}


psgrep() {
  if [[ "$1" = "-p" ]]; then
    shift;
    ps aux | grep -v grep | grep "$@" -i --color=auto | awk '{print $2}'
  else
    ps aux | grep -v grep | grep "$@" -i --color=auto
  fi
}

random-word() {
  shuf -n 1 /etc/dictionaries-common/words | sed "s/'s$//"
}

random-file() {
  BASE=$1
  FILE=$(ls $BASE | shuf -n 1)
  echo $BASE/$FILE
}

recent-branches() {
  N=${1:-20}
  git reflog | grep checkout | awk '!seen[$6]++ {print $6}' | head -n $N
}

git-delete-old-merged-branches() {
    local date_range="2 weeks ago"
    local force_delete=false

    if [[ "$1" == "-f" ]] || [[ "$1" == "--force" ]]; then
        force_delete=true
        shift
    fi

    if [ ! -z "$1" ]; then
        date_range="$1"
    fi

    if ! $force_delete; then
      echo "Running in dry run mode.  Use --force or -f to delete"
    fi

    git branch --merged main | grep -v "\* main" | while read branch; do
        if [ "$(git log -1 --since="$date_range" -s $branch)" == "" ]; then
            if $force_delete; then
                git branch -d $branch
            else
                echo "Branch to be deleted: $branch"
            fi
        fi
    done
}


cdr() {
  cd $1
  tmux rename-window $1
}

zr() {
  z $1
  tmux rename-window `basename "$PWD"`
}

most-frequent-commands() {
  history | awk '{a[$4] += 1} END {for(i in a) print a[i], i}' | sort -V
}

# Change iterm profile
# https://coderwall.com/p/t7a-tq/change-terminal-color-when-ssh-from-os-x
function change-profile() {
  NAME=$1; if [ -z "$NAME" ]; then NAME="Default"; fi
  # if you have trouble with this, change
  # "Default" to the name of your default theme
  echo -e "\033]50;SetProfile=$NAME\a"
}

alert() {
  osascript -e "display alert \"$1\"" > /dev/null
}

select-rows() {
  file=$1
  start=$2
  end=${3:-$2}
  if ! [ -f "$file" ]; then
    echo "First arg must be file"
  fi
  sed -n "$start,${end}p;$(( $end + 1 ))q" "$file"
}

nvim-switch() {
  local folder1=~/.local/share
  local folder2=~/.config

  if [ "$#" -eq 0 ]; then
    # List available suffixes
    local suffixes=($(ls -d ${folder1}/nvim.* | xargs -n1 basename | sed 's/^nvim\.//'))
    local current_suffix=$(readlink ${folder1}/nvim | sed 's/^nvim\.//')

    for suffix in "${suffixes[@]}"; do
      if [ "$suffix" == "$current_suffix" ]; then
        echo "* $suffix"
      else
        echo "  $suffix"
      fi
    done

  elif [ "$#" -eq 2 ] && [ "$1" == "-n" ]; then
    local new_suffix=$2

    # Create new directories
    mkdir -p "${folder1}/nvim.${new_suffix}"
    mkdir -p "${folder2}/nvim.${new_suffix}"

    # Update symlinks
    ln -sfn "nvim.${new_suffix}" "${folder1}/nvim"
    ln -sfn "nvim.${new_suffix}" "${folder2}/nvim"
    echo "Created and switched to nvim.${new_suffix}"

  elif [ "$#" -eq 1 ]; then
    local new_suffix=$1

    if [ -d "${folder1}/nvim.${new_suffix}" ] && [ -d "${folder2}/nvim.${new_suffix}" ]; then
      # Update symlinks
      ln -sfn "nvim.${new_suffix}" "${folder1}/nvim"
      ln -sfn "nvim.${new_suffix}" "${folder2}/nvim"
      echo "Switched to nvim.${new_suffix}"
    else
      echo "Error: nvim.${new_suffix} does not exist in both folders."
    fi

  else
    echo "Usage: nvim-switch [-n] [suffix]"
  fi
}

untracked-files() {
  # Get a list of untracked files
  FILES=$(git ls-files --others --exclude-standard --full-name)

  # Loop through each untracked file and print its details
  while read -r FILE; do
    LAST_MODIFIED=$(date -r "$FILE" "+%Y-%m-%d %H:%M:%S")
    printf '%-80s | %-20s\n' "$FILE" "$LAST_MODIFIED"
  done <<< "$FILES" | sort -t "|" -k2r | sed 's/|//'
}

run-on-all-files-changed-from-main() {
  git diff --stat origin/main | awk '{print $1}' | ghead -n -1 | xargs $@
}

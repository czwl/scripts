#!/bin/bash

# Search for all .git repos in all subdirectories
# cd into them
# And run a summarized git command or each git command


# Allow scanning worktrees
if [[ "$1" == "-w" ]]; then
	SCAN_WORKTREES=true
	shift
fi

command="$1"

SCAN_CACHE=".scancache.git-allsubdirs"

if [[ "$command" = "scan" ]]; then
   if [[ "$SCAN_WORKTREES" == true ]] ; then

  	find . -name .git  -prune -exec dirname {} \; | tee "$SCAN_CACHE"
   else

  	find . -name .git -type d -prune -exec dirname {} \; | tee "$SCAN_CACHE"
   fi
fi

if [[ ! -f "$SCAN_CACHE" ]]; then
  echo "Run scan first"
  exit 1
fi

# Show only changed files
if [[ "$command" = "status" ]]; then
  root=$(pwd)
  while read -r dir; do
    cd "$root/$dir" || exit
    git diff --exit-code &>/dev/null
    if (("$?" != 0)); then
      printf '\e[1;34m%-6s\e[m' "$dir \\n"
      git status
      printf "\n"
    fi
  done <"$SCAN_CACHE"
fi

if [[ "$command" = "fetchall" ]]; then
  root=$(pwd)
  while read -r dir; do
    cd "$root/$dir" || exit
    printf '\e[1;34m%-6s\e[m' "$dir \n"
    git fetch --all &
    printf "\n"
  done <"$SCAN_CACHE"
fi

if [[ "$command" = "remotes" ]]; then
  root=$(pwd)
  while read -r dir; do
    cd "$root/$dir" || exit
    printf "\e[1;34m%-6s\e[m $dir \n" 
    git remote -v
    printf "\n"
  done <"$SCAN_CACHE"
fi

# run custom git command
if [[ "$command" = "git" ]]; then
  root=$(pwd)
  while read -r dir; do
    cd "$root/$dir" || exit
    printf '\e[1;34m%-6s\e[m' "$dir \\n"
    git "${@:2}"
    printf "\\n"
  done <"$SCAN_CACHE"
fi

# find . -name .git -type d -prune | while IFS= read -r dir_git; do
#     dir=$(dirname $dir_git)
#     echo $dir
# done

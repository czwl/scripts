#!/bin/bash

# Search for all .git repos in all subdirectories
# cd into them
# And run a summarized git command or each git command

SCAN_CACHE=".scancache.git-allsubdirs"

sub_scan() {
	# Allow scanning worktrees
	if [[ "$1" == "-w" ]]; then
		SCAN_WORKTREES=true
		shift
	fi

	if [[ "$SCAN_WORKTREES" == true ]]; then

		find . -name .git -prune -exec dirname {} \; | tee "$SCAN_CACHE"
	else

		find . -name .git -type d -prune -exec dirname {} \; | tee "$SCAN_CACHE"
	fi
}

# Show only changed files
sub_status() {
	root=$(pwd)
	while read -r dir; do
		cd "$root/$dir" || exit

		if git diff --exit-code &>/dev/null; then
			printf '\e[1;34m%-6s\e[m' "$dir \\n"
			git status
			printf "\n"
		fi
	done <"$SCAN_CACHE"
}

sub_fetchall() {
	root=$(pwd)
	while read -r dir; do
		cd "$root/$dir" || exit
		printf '\e[1;34m%-6s\e[m' "$dir \n"
		git fetch --all &
		printf "\n"
	done <"$SCAN_CACHE"
}

sub_remotes() {
	root=$(pwd)
	while read -r dir; do
		cd "$root/$dir" || exit
		printf "\e[1;34m%-6s\e[m $dir \n"
		git remote -v
		printf "\n"
	done <"$SCAN_CACHE"
}

# run custom git command
sub_git() {
	root=$(pwd)
	while read -r dir; do
		cd "$root/$dir" || exit
		printf '\e[1;34m%-6s\e[m' "$dir \\n"
		git "${@}"
		printf "\\n"
	done <"$SCAN_CACHE"

}

subcommand=$1
case $subcommand in
"" | "-h" | "--help")
	sub_help
	;;
*)
	shift
	sub_"${subcommand}" "$@"
	if [ $? = 127 ]; then
		if [[ ! -f "$SCAN_CACHE" ]]; then
			echo "Run scan first"
			exit 1
		fi
		echo "Error: '$subcommand' is not a known subcommand." >&2
		echo "       Run '$progname --help' for a list of known subcommands." >&2
		exit 1
	fi
	;;
esac

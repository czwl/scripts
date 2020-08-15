#!/bin/bash
#
# Copyright (C) 20
# Website:
#
# SPDX-License-Identifier: Apache-2.0
#

## BASH IS CRAP. DONT USE BASH KIDS
## ONCE YOU USE BASH YOU DOWN THE RABBIT BUTT HOLE
## AND IT FUCKIN DARK AND IT SMELLS LIKE SHIT

BASE_DIR="$(
	cd "$(dirname "$(readlink -f "$0")")"
	pwd
)"

main() {
	progname="generic-commands"
	# Debugging
	# Allow debugging with a long option
	if [[ "$1" == '-V' || "$1" == '--verbose' ]]; then
		_ENABLE_DEBUG=true

		printf "base dir := %s" "$BASE_DIR"
		printf "commands: %s" "${@}"
		set -x
		shift
	fi

	subcommand=$2
	case $subcommand in
	"" | "-h" | "--help")
		sub_help
		;;
	*)

		if type -t "sub_${subcommand}"; then
			"sub_${subcommand}" "${@}"
		else
			echo "Error: '$subcommand' is not a known subcommand." >&2
			echo "       Run '$progname --help' for a list of known subcommands." >&2
			exit 1
		fi
		;;
	esac
}

declare -a COMMANDS

COMMANDS+=("help    Show this help text.")
sub_help() {
	echo "cmd args"
	echo "The following commands are availbale"
	cmds=""
	for c in "${COMMANDS[@]}"; do
		cmds+="$c \\n"
	done
	printf "%s" "$cmds"
}

main "$@"

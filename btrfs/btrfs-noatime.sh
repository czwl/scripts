#!/bin/bash

## Use noatime when performing lot of directories recursive read.

## Since btrfs metadata is CoW relatime will incur some writes when using realtime every 24h.

progname=$(basename $0)

sub_help() {
	printf "Usage: $progname <subcommand> [options] %c" $'\n'
	printf "Subcommands:"
	printf "    bar   Do bar"
	printf "    baz   Run baz"
	printf ""
	printf "For help with each subcommand run:"
	printf "$progname <subcommand> -h|--help"
	printf ""
}

sub_show() {
	printf "btrfs  \n\n"
	mount | grep btrfs
}

sub_mount() {
	mount | grep btrfs | cut -d ' ' -f3 | sudo xargs -n1 mount -o remount,noatime
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
		printf "Error: '$subcommand' is not a known subcommand." >&2
		printf "       Run '$progname --help' for a list of known subcommands." >&2
		exit 1
	fi
	;;
esac

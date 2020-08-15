#!/bin/bash

## Load node_modules in zRAM if available or RAM.

## You must call this from current directory or with --bind
## to setup the node_modules

## This script will automatic run itself as  if needed.

cwd="$(pwd)"

set -e -o pipefail

CACHED_NM_NAME="nm_cached.xz"

if ((EUID)); then
	echo 'This script must be run with sudo'
	echo 'This handles the real/effective user id properly '
	exit
fi

transports=("raw" "zram")

sub_setup() {

	case $config_tranport in
	zram)

		zdev="$(zramctl -a lzo -f -s 1.2G)"
		mkfs.f2fs "$zdev"
		mkdir /run/node_modules
		mount "$zdev" /run/node_modules
		chown -R "$SUDO_USER":users /run/node_modules
		chmod 0775 /run/node_modules
		;;

	*)
		mkdir /run/node_modules
		chown -R "$SUDO_USER":users /run/node_modules
		chmod 0775 /run/node_modules
		;;
	esac
}

sub_bind() {
	mount -o bind /run/node_modules/"$leaf_name" node_modules
}

sub_load() {
	sudo -u "$SUDO_USER" tar -I "lbzip2" -xf "$CACHED_NM_NAME" -C /run/node_modules
}

sub_save() {
	sudo -u "$SUDO_USER" tar -I "lbzip2 " -cf "$CACHED_NM_NAME" -C /run/node_modules "$leaf_name"
}

progname="node_zram"

subcommand=$1
case $subcommand in
"" | "-h" | "--help")
	sub_help
	;;
*)
	shift
	leaf_name="$(cat ./.git/._nm.leafhash)"
	sub_"${subcommand}" "$@"
	if [ $? = 127 ]; then
		echo "Error: '$subcommand' is not a known subcommand." >&2
		echo "       Run '$progname --help' for a list of known subcommands." >&2
		exit 1
	fi
	;;
esac

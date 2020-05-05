#!/bin/sh

if [[ -z  "$1" ]] ;
	echo "Wheres the link bruh ? "
	exit 2
fi;

curl  `echo "$@" | sed 's/github/raw.githubusercontent/' | sed 's|blob/||' | sed 's|tree/||'    `

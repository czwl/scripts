#!/usr/bin/env bash

#check for files which dont belong to user..

uid="$id -u"
files=($(find . ! -user "$uid"));

fixfunc() {
chmod 0600 ${@}
chown "$(id -u)".users ${@}
}

fixfunc $files

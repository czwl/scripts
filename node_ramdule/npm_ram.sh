#!/bin/bash

## Load node_modules in zRAM if available or RAM.

## You must call this from current directory or with --bind
## to setup the node_modules

## This script will automatic run itself as sudo if needed.

cwd="$(pwd)"

sub_setup() {
  zdev="$(zramctl -f -s 1.2G)"
  mkfs.f2fs "$zdev"
  mkdir /run/node_modules
  mount "$zdev" /run/node_modules
  chown -R users:users /run/node_modules
}

sub_bind() {
  leaf_name = "$cwd/node_modules/leaf"*
  mount -o bind /run/node_modules/$leaf_name node_modules
}

sub_load() {
  tar -xf ~/npm.xz -C /run/node_modules
}

sub_save() {
  tar -cf ~/npm.xz /run/node_modules
}

progname="node_zram"

subcommand=$1
case $subcommand in
  "" | "-h" | "--help")
    sub_help
    ;;
  *)
    shift
    sub_${subcommand} $@
    if [ $? = 127 ]; then
      echo "Error: '$subcommand' is not a known subcommand." >&2
      echo "       Run '$progname --help' for a list of known subcommands." >&2
      exit 1
    fi
    ;;
esac

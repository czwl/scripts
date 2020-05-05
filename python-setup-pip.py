#!/usr/bin/env bash

temp_file=$(mktemp)

curl https://bootstrap.pypa.io/get-pip.py -o $temp_file

python3 $temp_file --user

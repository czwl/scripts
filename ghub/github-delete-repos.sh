#!/bin/bash

REPO=$2
TOKEN=$1

curl -X DELETE -H "Authorization: token ${TOKEN}" "https://api.github.com/repos/${REPO}"
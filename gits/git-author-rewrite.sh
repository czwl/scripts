#!/bin/bash

# This command rewrites history

OLD_E="$1"
NEW_E="$2"
NEW_N="$3"



git filter-branch --env-filter "
OLD_EMAIL=$1
CORRECT_NAME=""
CORRECT_EMAIL="" '

if [ "$GIT_COMMITTER_EMAIL" = "$OLD_EMAIL" ]
then
    export GIT_COMMITTER_NAME="$CORRECT_NAME"
    export GIT_COMMITTER_EMAIL="$CORRECT_EMAIL"
fi
if [ "$GIT_AUTHOR_EMAIL" = "$OLD_EMAIL" ]
then
    export GIT_AUTHOR_NAME="$CORRECT_NAME"
    export GIT_AUTHOR_EMAIL="$CORRECT_EMAIL"
fi
' --tag-name-filter cat -- --branches --tags


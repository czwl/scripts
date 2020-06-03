#!/bin/bash

# -i, --ignore-errors    Continue on download errors, for example to skip
#                        unavailable videos in a playlist
# -w, --no-overwrites    Do not overwrite files
# -c, --continue         Force resume of partially downloaded files.
#                        By default, youtube-dl will resume downloads if possible.

youtube-dl -ciw --extract-audio --audio-format mp3 --audio-quality 0 -o "%(title)s.%(ext)s" "$1"

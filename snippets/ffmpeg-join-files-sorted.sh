ffmpeg -safe 0 -f concat -i <(find . -type f -name '*' -printf "file '$PWD/%p'\n" | sort) -c copy output.mkv

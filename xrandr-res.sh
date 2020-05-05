#!/bin/bash

RES="1920 1080 60"
DISP=$(xrandr | grep -e " connected [^(]" | sed -e "s/\([A-Z0-9]\+\) connected.*/\1/")
MODELINE=$(cvt $(echo $RES) | grep -e "Modeline [^(]" | sed -r 's/.*Modeline (.*)/\1/')
MODERES=$(echo $MODELINE | grep -o -P '(?<=").*(?=")')

xrandr --newmode "$MODERES" "$MODELINE"
xrandr --addmode $DISP $MODERES

#!/bin/bash

for F in *.tar.md5; do
	echo -n "$F "
	EXP=($(tail --lines=1 "$F"))
	ACT=($(head --lines=-1 "$F" | md5sum))

	if [[ ${EXP[0]} = ${ACT[0]} ]]; then
		echo "OK" "$F "
	else
		echo "FAIL"
	fi
done

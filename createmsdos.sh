#!/bin/sh
cd=./
if [ -z "$1" ]; then
	echo "Usage: $0 [Basedosdir] [Outdir] [Windowsdir]"
	exit 0
fi
if [ -n "$3" ]; then
	cd="$3"
fi
for d in `ls $1`; do
	cp "$cd/$d" "$2"
done

#!/bin/bash

usage="echo Usage: $0 Disk File"

if [[ x$1 == x ]]; then
	$usage;
	exit 0;
fi

if [[ x$2 == x ]]; then
	$usage;
	exit 0;
fi

if [[ $(dd if=$1 count=8 bs=1 skip=82 | uuencode -m -|head -n 2|tail -n 1) != "RkFUMzIgICA=" ]]; then
	echo "$1" "isn't" a FAT 32 partition;
	exit 1;
fi

if [ ! -f boot1f32 ]; then
	echo "$2 not found";
	exit 1;
fi

dd if=$1 of=/tmp/origbs bs=512 count=1
cp $2 /tmp/newbs
dd if=/tmp/origbs of=/tmp/newbs skip=3 seek=3 bs=1 count=87 conv=notrunc
dd if=/tmp/newbs of=$1 bs=512 count=1

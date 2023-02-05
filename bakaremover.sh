#!/bin/sh

b0=$(basename $0)
echo "馬鹿なプログラムを削除します。"

if [ x$1 = x ]; then
	echo "usage: $b0 logfile";
	echo "ログファイルは'/var/log/apt/history.log'に排出されているはずです。馬鹿なプログラムを消したい部分だけ抜き出してください。";
	exit 0;
fi

if ! [ -e $1 ]; then
	echo "'$1'：ファイルが見つかりません";
	exit 1;
fi

if ! [ $(whoami) = root ]; then
	echo "rootユーザーで実行してください";
	exit 0;
fi

removable=$(cat "$1" | grep "Install:" | sed 's/([^)]*)//g' | sed 's/,//g' | sed 's/Install://g')
apt purge $removable
exit 0

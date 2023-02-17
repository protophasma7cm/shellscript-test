#!/bin/sh
#####config#####
mirror_path=~/apt-mirror
amd64_get="dep11/icons-64x64@2.tar.gz cnf/Commands-amd64.xz"

#####script#####
echo "postmirror.sh, Ver. 22.8.5.2"
run_mirror()
{
	for c in `echo $3`;do
		for d in `echo $4`;do
			for dep in `echo $amd64_get`;do
				[ deb-amd64 != "$1" ] && break
				mkdir -p $(dirname "$mirror_path/mirror/`echo $2 | sed -e 's|http://||' -e 's|https://||'`/dists/$c/$d/$dep")
				wget $2/dists/$c/$d/$dep -nv -O "$mirror_path/mirror/`echo $2 | sed -e 's|http://||' -e 's|https://||'`/dists/$c/$d/$dep"
			done
		done
	done
}
grep deb /etc/apt/mirror.list | sed -e '/^#/d' -e '/=/d' -e '/deb-src/d' | \
while read l; do
	run_mirror $l
done

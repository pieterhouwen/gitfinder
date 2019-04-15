#!/bin/bash
HOST=$(cat /etc/hostname)
echo You probably should begin by installing (some) packages.
echo
echo First we need to make sure you have the right package list..
read gebruiker
scp -P 334 $gebruiker@tiki.pieterhouwen.info:/home/$gebruiker/$HOST /tmp/pkglist.txt
curdir=$(pwd)
echo Updating the package cache...
apt-get update >/dev/null
for package in $(cat /tmp/pkglist.txt)
do
apt-get install -y $package
done

function helloworld(){
echo Begin git cloning. . .
paste urllist dirlist | while read url dir
do
git clone $url $dir
done
echo Done cloning!
#removes old logs
echo Cleaning up old log files.
rm piplog
rm makelog

echo Installing requirements. . . This will take a while, go grab a cup of covfefe.
echo

# This function  Search Location for $1 wich is file type then store results in $2
function search_for() {
echo "create $1 list store in $2" #debug output
	(
		cd / ; find -name $1 -type f 2>/dev/null | grep -v dradis | grep -v autopwn | cut -c2- >$curdir/$2
	)
}

# trigger functions
search_for requirements.txt reqlist
search_for Makefile makelist

for require in $(cat $curdir/reqlist)
do
pip install -r $require --log $curdir/piplog 1>/dev/null 2>>$curdir/piplog
done
echo Done installing requirements!
echo Making some magic with magic makefiles
for makef in $(cat $curdir/makelist)
do
make $makef clean 2>>$curdir/makelog ; make $makef 2>>$curdir/makelog ; make $makef install 2>>$curdir/makelog
done


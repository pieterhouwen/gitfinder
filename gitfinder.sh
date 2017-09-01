#!/bin/bash
echo Searching for git repositories...
cd / ; find -name ".git" -type d 2>/dev/null >~/gitfinder/gitlist
cd / ; find -name ".git" -type d 2>/dev/null | sed "s/\/.git//" >~/gitfinder/dirlist

for url in $(cat ~/gitfinder/gitlist | grep -v dradis | cut -c2-)
do
cd $url ;  cat config 2>/dev/null | grep "http" >>~/gitfinder/completedlist.txt ; pwd >>~/gitfinder/completedlist.txt 
done
echo Results have been saved to completedlist.txt


#[plan]
# Have dirlist read out line by line 
# Have separate file for downloaded locations
# Maybe add a downloader in the future
#

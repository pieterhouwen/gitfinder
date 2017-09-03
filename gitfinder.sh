#!/bin/bash
echo Searching for git repositories...
startingpoint=$(pwd)
cd / ; find -name ".git" -type d 2>/dev/null >$startingpoint/gitlist


for url in $(cat $startingpoint/gitlist | grep -v dradis | cut -c2-)
do
cd $url ;  cat config 2>/dev/null | grep "http" | cut -c8- >>$startingpoint/completedlist.txt ; cd .. && pwd >>$startingpoint/completedlist.txt 
done
echo Results have been saved to completedlist.txt


#[plan]
# Have dirlist read out line by line 
# Have separate file for downloaded locations
# Maybe add a downloader in the future
#

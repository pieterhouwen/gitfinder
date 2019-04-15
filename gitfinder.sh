#!/bin/bash
echo Searching for git repositories...
cd=$(pwd)
rm -f urllist dirlist
# To know where to put the path names and the directory names and locations.
cd / ; find -name ".git" -type d 2>/dev/null | grep -v dradis | cut -c2- >$cd/gitlist


for url in $(cat $cd/gitlist)
do
cd $url ;  cat config 2>/dev/null | grep "http" | cut -c8- >>$cd/urllist ; cd .. && pwd >>$cd/dirlist 
done
echo "Results have been saved to urllist and dirlist."
echo
exit 0

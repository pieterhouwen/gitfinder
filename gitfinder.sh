
#!/bin/bash
# Setting hostname as variable
HOST=$(cat /etc/hostname)
echo Voer de gebruiker in:
read gebruiker
# User has been set for ssh access
echo $gebruiker
#echo Searching for git repositories...
#cd=$(pwd)
if [ -z "$1" ]
then
echo Default will be used: ~/mysshpass
passfile=~/mysshpass
else
echo Setting passfile to $1
passfile=$("$1")
fi

rm -f urllist dirlist
# To know where to put the path names and the directory names and locations.
#cd / ; find -name ".git" -type d 2>/dev/null | grep -v dradis | cut -c2- >$cd/gitlist


#for url in $(cat $cd/gitlist)
#do
#cd $url ;  cat config 2>/dev/null | grep "http" | cut -c8- >>$cd/urllist ; cd .. && pwd >>$cd/dirlist 
#done
#echo "Results have been saved to urllist and dirlist."
#echo
echo Compiling list of installed packages...
dpkg --get-selections | cut -f 1 >/tmp/pkglist.txt
echo Searching for sshpass package...
grep sshpass /tmp/pklist.txt >/dev/null 2>/dev/null
if [ $? == "1" ]
then
echo Sshpass has not been found, installing it anyway..
echo Updating package cache...
apt-get update >/dev/null
apt-get install sshpass -y
echo Package installed \(or not?\).
break
else
echo There was no error. Continuing...
echo passfile=$passfile
echo gebruiker=$gebruiker
echo HOST=$HOST

sshpass -f $passfile scp -P 334 /tmp/pkglist.txt $gebruiker@tiki.pieterhouwen.info:/home/$gebruiker/$HOST
if [ $? == "1" ]
then
echo Something has gone wrong, please review output and try again.
else
echo Succeeded!
fi
fi


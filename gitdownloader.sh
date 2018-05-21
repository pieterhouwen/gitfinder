curdir=$(pwd)

function stabbie() {

# ================================
function urlcheck() {
echo Input your gitlist URL
read url1
echo please input the dirlist url
read url2
echo is this information correct
echo gitlist = $url1
echo dirlist = $url2
select yn in "Yes" "No"; do
case $yn in
Yes )
break
;;
No ) 
read url1
echo 'now the urllist = '$url1
read url2
echo 'now dirlist = '$url2
echo is this correct?
# ========
select yn in "Yes" "No"; do
case $yn in
Yes )
break
;;
No )
urlcheck
;;
esac
done
# =======
;;
esac
done
}
# ==============================

echo Hi want to get your lists from pastebin?
options=("Yes, use PasteBin" "No, don't use PasteBin")
select opt in "${options[@]}"
do
case $opt in
"Yes, use PasteBin")
urlcheck
key=$(echo  $url | cut -d "/" -f4-)
curl https://pastebin.com/raw/$key | base64 -d > urllist
break
;;
"No, don't use PasteBin")
echo "Alrighty then. Just use the urllist and dirlist." 
echo "Have a nice day!"
break
;;
esac
done
}

stabbie

echo end test


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

#function searchfiles {
#for file in $(cat dirlist)
#do 
#cd $file && find -name $1 
}
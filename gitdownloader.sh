curdir=$(pwd)
#paste urllist dirlist | while read url dir
#do
#git clone $url $dir
#done

#removes old logs
rm piplog
rm makelog

echo Done cloning!
echo Installing requirements. . . This will take a while, go grab a cup of covfefe.
echo

# This function  Search Location for $1 wich is file type then store results in $2
function search_for() {
echo 
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
pip install -r $require --log $curdir/piplog 1>/dev/null
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

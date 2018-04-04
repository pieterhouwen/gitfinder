curdir=$(pwd)
paste urllist dirlist | while read url dir
do
git clone $url $dir
done
echo Done cloning!
echo Installing requirements. . .
for i in $(cat dirlist)
do
cd $i && pip install -r requirements.txt
done

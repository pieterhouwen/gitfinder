paste urllist dirlist | while read url dir
do
git clone $url $dir
done

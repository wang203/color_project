#!/bin/bash
#
# download_flickr_images.sh urls_file hdfs_dir
#
#  urls_file :   file with "pid url" pairs, one on each line
#  hdfs_dir  :   (optional) if given, also copy images to hdfs
#
# Creates a directory called "photos" to receive them.
# To help make things more manageable, also breaks the download into 90
#   separate chunks.
#

source ~/projects/hadoop-vision/scripts/common.sh

die_if_toofew_args "$#" 1;

URLS_FILE=$1
mkdir photos1
cd photos1

echo 'Downloading images...'
for (( i=10; i<=99; i++ )); do
    if [ ! -d $i ]; then
	mkdir $i
	cd $i
	cat ${URLS_FILE} | awk '$1 ~ /^'$i'/ { print $2; }' | wget -nv -i - --max-redirect=0
	cd ..
    fi
done

cd ..



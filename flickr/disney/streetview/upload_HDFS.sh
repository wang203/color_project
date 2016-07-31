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

HDFS_DIR=${1:-""}
echo $HDFS_DIR

if [ "$HDFS_DIR" != "" ]; then
    
    hdfs_dir_exists EXISTS $HDFS_DIR
    echo $EXISTS
    if [ "$EXISTS" -eq 0 ]; then
	cd photos
	
	echo 'Copying images to HDFS...'
	hadoop dfs -mkdir $HDFS_DIR
	${SCRIPTS_DIR}/load_images_to_hdfs.sh . $HDFS_DIR -f
	
	cd ..
    fi
fi

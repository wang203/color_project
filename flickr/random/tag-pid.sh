GROUP='test.2014-07-09_180432.10000.sample'
DIR=~/projects/hadoop-vision/scripts
FLICKR_DIR=${DIR}/../flickr

# sed 's/@N//g;' $GROUP.photos | sort -k2 > tag/random.photospidsort
sed 's/@N//g;' $GROUP.photos | sort -k1 > tag/random.photosuidsort

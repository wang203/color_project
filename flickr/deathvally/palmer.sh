GROUP='deathvally'
DIR=~/projects/hadoop-vision/scripts
FLICKR_DIR=${DIR}/../flickr
SCRIPT_DIR='/l/vision/wang203/colorproj/flickr/script'

# hadoop with -palmer option => deathvally.hadoop_output_palmer
# same for streetview
python $SCRIPT_DIR/palmer.py 'deathvally'
# $1 = 'deathvally' or 'streetview'


GROUP='deathvally'
DIR=~/projects/hadoop-vision/scripts
FLICKR_DIR=${DIR}/../flickr
SCRIPT_DIR='/l/vision/wang203/colorproj/flickr/script'

# python gray_image.py
# sort streetview-nongray > streetview-nongraysort
# join -1 1 -2 1 streetview-nongraysort ../deathvally.hadoop-input | awk '{print $2" "$3;}' | sort -k1 > nongray.uniqiduid
# ${FLICKR_DIR}/scripts/join_lookup.sh 1 1 nongray.piduid ../deathvally.hadoop_output > ../deathvally.hadoop_output_withstreet

HDFS_NAME=$GROUP'_streetview_nongray'
# echo $HDFS_NAME
# hadoop fs -rmr $HDFS_NAME
# sh upload_HDFS.sh /user/wang203/$HDFS_NAME
# 
# 
#####################################################################################
########################   fake the hadoop-input file    ########################
#####################################################################################

# head -2 ../$GROUP'.hadoop-input' | tail -1 > streetview.hadoop-input-nongray
# 
# lenstr=$(wc -l nongray.uniqiduid)
# len=$(echo $lenstr | cut -d' ' -f1)
# echo $len
# awk '{for(i=0;i<'$len';i++)print;}' streetview.hadoop-input-nongray > streetview.hadoop-input0-nongray
# 
# # make up hadoop input
# paste nongray.uniqiduid streetview.hadoop-input0-nongray | awk -F ' ' '{$3=""; $4=""; print;}' > streetview.hadoop-input-nongray
# rm streetview.hadoop-input0-nongray
# 
# ##paste the first line
# var=$(head -1 ../$GROUP.hadoop-input)
# echo $var
# sed -i "1s/.*/$var/" streetview.hadoop-input-nongray



########## hadoop computing ##################
# to have hadoop works hadoop file always has to be 10.seq etc.

sh ~/projects/hadoop-vision/apps/gender-colors/scripts/gender-colors.sh /user/wang203/$HDFS_NAME streetview.hadoop-input-nongray
###sh ~/projects/hadoop-vision/scripts/fetch_output_from_hdfs.sh <hadoop output file name> streetview.hadoop_output



GROUP='disney'
DIR=~/projects/hadoop-vision/scripts
FLICKR_DIR=${DIR}/../flickr
SCRIPT_DIR='/l/vision/wang203/colorproj/flickr/script'



# # get GPS in bounding box
# awk '{print $1" "$2" "$10" "$11;}' ../$GROUP.photos | sort -k1 -k2 > $GROUP.uidpidgeo
# 
# ## get street view urls
# # https://maps.googleapis.com/maps/api/streetview?size=600x300&location=46.414382,10.013988&heading=151.78&pitch=-0.76&key=YOUR_API_KEY
# cat $GROUP.uidpidgeo | awk '{printf("%s %s https://maps.googleapis.com/maps/api/streetview?size=100x100&location=%s,%s&heading=0&pitch=0&key=%s\n", $1, $2, $3, $4, "AIzaSyB6I_6gNeXnleE_ojsCSh-a9mFSrVwMsc0");}' > streetview.uidpidurl
# cat $GROUP.uidpidgeo | awk '{printf("%s %s https://maps.googleapis.com/maps/api/streetview?size=100x100&location=%s,%s&heading=90&pitch=0&key=%s\n", $1, $2, $3, $4, "AIzaSyB6I_6gNeXnleE_ojsCSh-a9mFSrVwMsc0");}' >> streetview.uidpidurl
# cat $GROUP.uidpidgeo | awk '{printf("%s %s https://maps.googleapis.com/maps/api/streetview?size=100x100&location=%s,%s&heading=180&pitch=0&key=%s\n", $1, $2, $3, $4, "AIzaSyB6I_6gNeXnleE_ojsCSh-a9mFSrVwMsc0");}' >> streetview.uidpidurl
# cat $GROUP.uidpidgeo | awk '{printf("%s %s https://maps.googleapis.com/maps/api/streetview?size=100x100&location=%s,%s&heading=270&pitch=0&key=%s\n", $1, $2, $3, $4, "AIzaSyB6I_6gNeXnleE_ojsCSh-a9mFSrVwMsc0");}' >> streetview.uidpidurl

# #download images first without uplaod to HDFSi
# sh download_streetview_images.sh $PWD/streetview.urls

# python $SCRIPT_DIR'/'gray_image.py $PWD'/'
sort streetview-nongray > streetview-nongraysort
join -1 1 -2 1 streetview-nongraysort ../$GROUP.hadoop-input | awk '{print $2" "$3;}' | sort -k1 > nongray.uniqiduid
${FLICKR_DIR}/scripts/join_lookup.sh 1 1 nongray.piduid ../$GROUP.hadoop_output > ../$GROUP.hadoop_output_withstreet
# 
# HDFS_NAME=$GROUP'_streetview_nongray'
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

# sh ~/projects/hadoop-vision/apps/gender-colors/scripts/gender-colors.sh /user/wang203/$HDFS_NAME streetview.hadoop-input-nongray
###sh ~/projects/hadoop-vision/scripts/fetch_output_from_hdfs.sh <hadoop output file name> streetview.hadoop_output


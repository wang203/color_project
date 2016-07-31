GROUP='sdzoo'

# # select metadata according to geo box
# sh /u/wang203/projects/hadoop-vision/flickr/scripts/flickr_photos_within_box.sh /l/vision/datasets/flickr-metadata/merge-files/2013-05-01/may_2013.merged.sort 32.724855 -117.159364 32.741174 -117.133873 12 > $GROUP.photos
# 
# # build urls according to metadata
# sh /u/wang203/projects/hadoop-vision/flickr/scripts/flickr_urls.sh $GROUP.photos t > $GROUP.urls
# 
# # download photos and upload to HDFS
# hadoop fs -rmr $GROUP
# ### rm -r photos
# sh /u/wang203/projects/hadoop-vision/apps/gender-colors/scripts/download_flickr_images.sh $PWD/$GROUP.urls /user/wang203/$GROUP
# 
# # get UID for user profile data
# awk '{print $1;}' $GROUP.photos | sort | uniq > $GROUP.uids
# 
# # get user profile data including hadoop input
# sh /u/wang203/projects/hadoop-vision/apps/gender-colors/scripts/download_flickr_user_profiles.sh $GROUP.uids
# 
# # compute color histogram on hadoop
sh ~/projects/hadoop-vision/apps/gender-colors/scripts/gender-colors.sh /user/wang203/$GROUP $GROUP.hadoop-input

# get results from HDFS to local
# sh ~/projects/hadoop-vision/scripts/fetch_output_from_hdfs.sh <hadoop output file name> $GROUP.hadoop_output


# # for ploting street view and flickr together
# awk '$4==1||$4==2 {print;}' $GROUP.hadoop_output > $GROUP.hadoop_flickr
# awk '{$4='3'; print;}' streetview/streetview.hadoop_output > $GROUP.hadoop_streetview
# cat $GROUP.hadoop_flickr $GROUP.hadoop_streetview > $GROUP.plotdata
# awk '{$4='4'; print;}' $GROUP.hadoop_flickr | cat $GROUP.plotdata - > $GROUP.plotdata4


## start Matlab
## addpath('~/projects/hadoop-vision/apps/gender-colors/scripts');
## data=load_hadoop_output('local-file');
## plot_wrapper('genders', 'all', data);



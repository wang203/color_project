GROUP='deathvally'

# # select metadata according to geo box
# sh /u/wang203/projects/hadoop-vision/flickr/scripts/flickr_photos_within_circle.sh /l/vision/datasets/flickr-metadata/merge-files/2013-05-01/may_2013.merged.sort 36.455251 -117.916099 1.2 13 > $GROUP.photos
# 
# wc -l $GROUP.photos

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
# wc -l $GROUP.uids
# 
# # get user profile data including hadoop input
# sh /u/wang203/projects/hadoop-vision/apps/gender-colors/scripts/download_flickr_user_profiles.sh $GROUP.uids
# # 
# # compute color histogram on hadoop
# sh ~/projects/hadoop-vision/apps/gender-colors/scripts/gender-colors.sh /user/wang203/$GROUP $GROUP.hadoop-input
# 
# # get results from HDFS to local
# ##sh ~/projects/hadoop-vision/scripts/fetch_output_from_hdfs.sh tmp/deathvally.hadoop-input-2016-01-18_142251_132009342-outputdir $GROUP.hadoop_output
# 
# 
# # for ploting street view and flickr together
# awk '$4==1||$4==2 {print;}' $GROUP.hadoop_output_withstreet > $GROUP.hadoop_flickr_withstreet
# awk '{$4='3'; print;}' streetview/streetview.hadoop_output_nongray > $GROUP.hadoop_streetview_nongray
# cat $GROUP.hadoop_flickr_withstreet $GROUP.hadoop_streetview_nongray > $GROUP.plotdata_nongray
# awk '{$4='4'; print;}' $GROUP.hadoop_flickr_withstreet | cat $GROUP.plotdata_nongray - > $GROUP.plotdata4

# for ploting street view and flickr together
awk '$4==1||$4==2 {print;}' $GROUP.hadoop_output_palmer > $GROUP.hadoop_flickr_withstreet_palmer
awk '{$4='3'; print;}' streetview/streetview.hadoop_output_palmer > $GROUP.hadoop_streetview_nongray_palmer
cat $GROUP.hadoop_flickr_withstreet_palmer $GROUP.hadoop_streetview_nongray_palmer > $GROUP.plotdata_nongray_palmer
awk '{$4='4'; print;}' $GROUP.hadoop_flickr_withstreet_palmer | cat $GROUP.plotdata_nongray_palmer - > $GROUP.plotdata4_palmer

## start Matlab
## addpath('~/projects/hadoop-vision/apps/gender-colors/scripts');
## data=load_hadoop_output('local-file');
## plot_wrapper('genders', 'all', data);




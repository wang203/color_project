################################################################################################
##############                    street view                  ########################
################################################################################################

GROUP='deathvally'

# # get GPS in bounding box
# awk '{print $1" "$2" "$10" "$11;}' ../$GROUP.photos | sort -k1 -k2 > $GROUP.uidpidgeo
# 
# ## get street view urls 
# # https://maps.googleapis.com/maps/api/streetview?size=600x300&location=46.414382,10.013988&heading=151.78&pitch=-0.76&key=YOUR_API_KEY
# cat $GROUP.uidpidgeo | awk '{printf("%s %s https://maps.googleapis.com/maps/api/streetview?size=100x100&location=%s,%s&heading=0&pitch=0&key=%s\n", $1, $2, $3, $4, "AIzaSyB6I_6gNeXnleE_ojsCSh-a9mFSrVwMsc0");}' > streetview.uidpidurl
# cat $GROUP.uidpidgeo | awk '{printf("%s %s https://maps.googleapis.com/maps/api/streetview?size=100x100&location=%s,%s&heading=90&pitch=0&key=%s\n", $1, $2, $3, $4, "AIzaSyB6I_6gNeXnleE_ojsCSh-a9mFSrVwMsc0");}' >> streetview.uidpidurl
# cat $GROUP.uidpidgeo | awk '{printf("%s %s https://maps.googleapis.com/maps/api/streetview?size=100x100&location=%s,%s&heading=180&pitch=0&key=%s\n", $1, $2, $3, $4, "AIzaSyB6I_6gNeXnleE_ojsCSh-a9mFSrVwMsc0");}' >> streetview.uidpidurl
# cat $GROUP.uidpidgeo | awk '{printf("%s %s https://maps.googleapis.com/maps/api/streetview?size=100x100&location=%s,%s&heading=270&pitch=0&key=%s\n", $1, $2, $3, $4, "AIzaSyB6I_6gNeXnleE_ojsCSh-a9mFSrVwMsc0");}' >> streetview.uidpidurl




###################################################################################
######################   fake UID   ########################
###################################################################################

GROUP='streetview'
# FILENAME='streetview.uid'

# echo '10' > $FILENAME
# for ((i=11; i<=99; i++)); do
#     echo $i >> $FILENAME
# done
# 
# 
# lenurlstr=$(wc -l streetview.url)
# lenurl=$(echo $lenurlstr | cut -d' ' -f1)
# rep1=$(($lenurl/90))
# rep=$((rep1+1))
# echo $rep 
# 
# awk '{for(i=0;i<'$rep';i++)print;}' $FILENAME > $FILENAME's'
# 
# echo $len
# 
# head -n $lenurl $FILENAME's' > $FILENAME'_sed'
# # 
# paste -d ' ' $FILENAME'_sed' streetview.url > streetview.urls               
# # download images and upload to HDFS
#   ##hadoop fs -rmr streetview
# rm $FILENAME*                                                                      # ## ## rm -r photos

# #download images first without uplaod to HDFS
# 
# sh download_streetview_images.sh $PWD/streetview.urls


#################################################################################
####################   rename street view files   ########################
# #################################################################################
# 
# chmod -R 777 photos/
# pidfile='streetview.pids'
# echo 'pid' > $pidfile
# cd photos
# cd 10
# for ((i=10; i<=99; i++)); do
#     cd ../$i
# 
#     files=(*)
#     if [ "$(ls -A )" ]; then
# 
#         echo $PWD
#         for index in "${!files[@]}"; do
#            file=${files[$index]}
#            ext='jpg'
#            newname=$(printf "%s%d_.%s" $i $((index+1)) "$ext")
#            #echo $file
#            #echo $newname
#            mv $file $newname
#            echo $newname >> ../../$pidfile
#         done
#     fi
# done
# cd ../../
# 
##  cd photos
##  pidfile='streetview.pids'
##  echo 'pid' > ../$pidfile
##  cd 10
##  for ((i=10; i<=99; i++)); do
##      cd ../$i
##  
##      files=(*)
##      if [ "$(ls -A )" ]; then
##          echo $PWD
##          for index in "${!files[@]}"; do
##             file=${files[$index]}
##             echo $file >> ../../$pidfile
##          done
##      fi
##  done
##  cd ../../
# 
##  cd photos
##  for ((i=10; i<=99; i++)); do
##      mv *$i $i
##  done
##  cd ..
# 
# 
HDFS_NAME=$GROUP'_streetview'
echo $HDFS_NAME
# hadoop fs -rmr $HDFS_NAME
# sh upload_HDFS.sh /user/wang203/$HDFS_NAME
# 
# 
#####################################################################################
########################   fake the hadoop-input file    ########################
#####################################################################################

# head -2 ../$GROUP.hadoop-input | tail -1 > streetview.hadoop-input
# 
# lenstr=$(wc -l streetview.pids)
# len=$(echo $lenstr | cut -d' ' -f1)
# echo $len
# awk '{for(i=0;i<'$len';i++)print;}' streetview.hadoop-input > streetview.hadoop-input0
# 
# # make up hadoop input
# cat streetview.pids | awk -F '_' '{print $1;}' - | paste - streetview.hadoop-input0 | awk -F ' ' '{$2=$1; $3=""; print;}' > streetview.hadoop-input
# rm streetview.hadoop-input0

# ##paste the first line
# var=$(head -1 ../$GROUP.hadoop-input)
# echo $var
# sed -i "1s/.*/$var/" streetview.hadoop-input
# 
# 
# 
############ hadoop computing ##################
## to have hadoop works hadoop file always has to be 10.seq etc.
# 
# sh ~/projects/hadoop-vision/apps/gender-colors/scripts/gender-colors.sh /user/wang203/$HDFS_NAME streetview.hadoop-input
# ###sh ~/projects/hadoop-vision/scripts/fetch_output_from_hdfs.sh <hadoop output file name> streetview.hadoop_output
# 
# 
# 
# 
# 
# 
# 
# 
# ## start Matlab
# ## addpath('~/projects/hadoop-vision/apps/gender-colors/scripts');
# ## data=load_hadoop_output('local-file');
# ## plot_wrapper('genders', 'all', data);
# 
# 
# 
# 

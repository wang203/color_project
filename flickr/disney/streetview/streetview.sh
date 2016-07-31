################################################################################################
##############                    street view                  ########################
################################################################################################

# # get GPS in bounding box
# awk '{print $10" "$11;}' ../disney.photos | sort -k1 -k2 > disney.geo
# 
# ##get street view urls 
# # https://maps.googleapis.com/maps/api/streetview?size=600x300&location=46.414382,10.013988&heading=151.78&pitch=-0.76&key=YOUR_API_KEY
# cat disney.geo | awk '{printf("https://maps.googleapis.com/maps/api/streetview?size=100x100&location=%s,%s&heading=0&pitch=0&key=%s\n", $1, $2, "AIzaSyB6I_6gNeXnleE_ojsCSh-a9mFSrVwMsc0");}' > streetview.url
# cat disney.geo | awk '{printf("https://maps.googleapis.com/maps/api/streetview?size=100x100&location=%s,%s&heading=90&pitch=0&key=%s\n", $1, $2, "AIzaSyB6I_6gNeXnleE_ojsCSh-a9mFSrVwMsc0");}' >> streetview.url
# cat disney.geo | awk '{printf("https://maps.googleapis.com/maps/api/streetview?size=100x100&location=%s,%s&heading=180&pitch=0&key=%s\n", $1, $2, "AIzaSyB6I_6gNeXnleE_ojsCSh-a9mFSrVwMsc0");}' >> streetview.url
# cat disney.geo | awk '{printf("https://maps.googleapis.com/maps/api/streetview?size=100x100&location=%s,%s&heading=270&pitch=0&key=%s\n", $1, $2, "AIzaSyB6I_6gNeXnleE_ojsCSh-a9mFSrVwMsc0");}' >> streetview.url




###################################################################################
######################   fake UID   ########################
###################################################################################

# GROUP='streetview'
# FILENAME='streetview.uid'
# 
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
# #echo $len
# 
# head -n $lenurl $FILENAME's' > $FILENAME'_sed'
# 
# paste -d ' ' $FILENAME'_sed' streetview.url > streetview.urls               
# # # download images and upload to HDFS
#                                                                                    # hadoop fs -rmr streetview
# rm $FILENAME*                                                                      # ## ## rm -r photos
# 
# ##download images first without uplaod to HDFS
# 
# sh download_streetview_images.sh $PWD/streetview.urls


###################################################################################
######################   rename street view files   ########################
###################################################################################

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


##pidfile='streetview.pids'
##echo 'pid' > $pidfile
##cd photos
##cd 10
##for ((i=10; i<=99; i++)); do
##    cd ../$i
##
##    files=(*)
##    if [ "$(ls -A )" ]; then
##        echo $PWD
##        for index in "${!files[@]}"; do
##           file=${files[$index]}
##           echo $file >> ../../$pidfile
##        done
##    fi
##done
##cd ../../

# cd photos
# for ((i=10; i<=99; i++)); do
#     mv *$i $i
# done
# cd ..


HDFS_NAME='disney_streetview'
# hadoop fs -rmr $HDFS_NAME
# sh upload_HDFS.sh /user/wang203/$HDFS_NAME


#####################################################################################
########################   fake the hadoop-input file    ########################
#####################################################################################
 
# head -2 ../disney.hadoop-input | tail -1 > streetview.hadoop-input
# 
# lenstr=$(wc -l streetview.pids)
# len=$(echo $lenstr | cut -d' ' -f1)
# echo $len
# awk '{for(i=0;i<'$len';i++)print;}' streetview.hadoop-input > streetview.hadoop-input0
# 
# # make up hadoop input
# cat streetview.pids | awk -F '_' '{print $1;}' - | paste - streetview.hadoop-input0 | awk -F ' ' '{$2=$1; $3=""; print;}' > streetview.hadoop-input
# rm streetview.hadoop-input0
# 
# # paste the first line
# var=$(head -1 ../disney.hadoop-input)
# echo $var
# sed -i "1s/.*/$var/" streetview.hadoop-input

sh ~/projects/hadoop-vision/apps/gender-colors/scripts/gender-colors.sh /user/wang203/$HDFS_NAME streetview.hadoop-input
##sh ~/projects/hadoop-vision/scripts/fetch_output_from_hdfs.sh tmp/streetview.hadoop-input-2016-01-23_001810_479056568-outputdir streetview.hadoop_output


## start Matlab
## addpath('~/projects/hadoop-vision/apps/gender-colors/scripts');
## data=load_hadoop_output('local-file');
## plot_wrapper('genders', 'all', data);


























#####################################################################################
########################   mv images to 10,11 like folders   ########################
#####################################################################################

# # rename files with '_' first
# for file in photos/*.jpg
# do
#     mv $file ${file/photos\/im/photos\/}
# done


# # !!!!!!!!!!!!!!!!!!! write filenames to a file!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!
# 
# cd photos
# 
# for ((i=10; i<=99; i++)); do
#     mkdir $i
#     mv $i*.jpg $i/ 
# done



# #####################################################################################
# ########################   fake UID   ########################
# #####################################################################################
# 
# 
# # echo '10' > $FILENAME
# # for ((i=11; i<=99; i++)); do
# #     echo $i >> $FILENAME
# # done
# # 
# # awk '{for(i=0;i<900;i++)print;}' $FILENAME > $FILENAME's'
# # 
# # lenstr=$(wc -l disney.streetview_url)
# # len=$(echo $lenstr | cut -d' ' -f1)
# # echo $len
# # 
# # head -n $len $FILENAME's' > $FILENAME'_sed'
# # 
# # paste -d ' ' $FILENAME'_sed' disney.streetview_url > streetview.urls
# # 
# # rm $FILENAME*


# ###################################################################################
# ######################   rename street view files   ########################
# ###################################################################################
# 
# cd photos
# pidfile='streetview.uids'
# echo 'pid' > ../$pidfile
# cd 10
# for ((i=10; i<=99; i++)); do
#     cd ../$i
# 
#     files=(*)
#     if [ "$(ls -A )" ]; then
#         echo $PWD
#         for index in "${!files[@]}"; do
#            file=${files[$index]}
#            echo $file >> ../../$pidfile
#            # ext='jpg'
#            # newname=$(printf "%s%d_.%s" $i $((index+1)) "$ext")
#            # mv "$file" "$newname"
#            # echo 'print file: '$file
#            # echo $newname >> ../../$pidfile
#         done
#     fi
# done
# cd ../../
# # upload to HDFS
# hadoop fs -rmr streetview
# sh /u/wang203/projects/hadoop-vision/apps/gender-colors/scripts/download_flickr_images.sh $PWD/streetview.urls /user/wang203/streetview

#####################################################################################
########################   fake the hadoop-input file    ########################
#####################################################################################
 
# lenstr=$(wc -l streetview.uids)
# len=$(echo $lenstr | cut -d' ' -f1)
# echo $len
# awk '{for(i=0;i<'$len';i++)print;}' streetview.hadoop-input > streetview.hadoop-input0
# 
# # make up hadoop input
# cat streetview.uids | awk -F '.' '{print $1;}' - | paste - streetview.hadoop-input0 | awk -F ' ' '{$2=$1; $3=""; print;}' > streetview.hadoop-input
# rm streetview.hadoop-input0
# # paste the first line

# awk '{print $1;}' streetview.hadoop-input | sed 's/^im\(.*\)$/\1/' - > streetview.pid
# cp streetview.hadoop-input streetview.hadoop-input0
# cat streetview.pid | paste - streetview.hadoop-input0 | awk -F ' ' '{$2=$1; $3=""; print;}' > streetview.hadoop-input00

# sh ~/projects/hadoop-vision/apps/gender-colors/scripts/gender-colors.sh /user/wang203/streetview streetview.hadoop-input
# sh ~/projects/hadoop-vision/scripts/fetch_output_from_hdfs.sh <hadoop output file name> streetview.hadoop_output








## start Matlab
## addpath('~/projects/hadoop-vision/apps/gender-colors/scripts');
## data=load_hadoop_output('local-file');
## plot_wrapper('genders', 'all', data);


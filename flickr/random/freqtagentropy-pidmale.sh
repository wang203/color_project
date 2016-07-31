GROUP='random'
DIR=~/projects/hadoop-vision/scripts
FLICKR_DIR=${DIR}/../flickr
SCRIPT_DIR='/l/vision/wang203/colorproj/flickr/script'


# mkdir tagmale
# awk '$4==2 {print $1;}' $GROUP.hadoop_output_photos | sort > tagmale/pidsort 
# ${FLICKR_DIR}/scripts/join_lookup.sh 1 2 tagmale/pidsort tag/$GROUP.photospidsort | awk '{print $1" "$20;}' | uniq > tagmale/pidtag

tagperuser='tagmale/pidfiltered.tagperuser'

# awk '$4==2 {print;}' $GROUP.hadoop_output_photos > tagmale/$GROUP.hadoop_output_photosgender

# python $SCRIPT_DIR/toppidperbin-threading.py '/l/vision/wang203/colorproj/flickr/'$GROUP'/tagmale/' $GROUP.hadoop_output_photosgender

# for i in {1..65}; do
#   ${FLICKR_DIR}/scripts/join_lookup.sh 1 2 tagmale/toppid$i tag/$GROUP.photospidsort | awk '{print $2" "$20;}' | sort -k1 | uniq > tagmale/pidfiltered.uidtag$i
#   python mergeuidtag.py tagmale/pidfiltered.uidtag$i $tagperuser$i
#   tr ',' '\n' < $tagperuser$i | sed '/^$/d' | sort | uniq -c | sort -nrk1,1 > $tagperuser'count'$i
#   
# done



tagcount='tagmale/pidfiltered.tagcount'
# echo 'tag totalnum bin1 ... bin65' > $tagcount
# echo 'tag totalnum bin1 ... bin65' > $tagcount'0'
# while read -r line
# do
#   targettag=$(echo $line | awk '{print $2;}')
#   totalnum=$(echo $line | awk '{print $1;}')
#   output=$targettag" "$totalnum
#   output0=$targettag" "$totalnum
#   for i in {1..65}; do
#     binnum=$(grep '\ '$targettag'$' $tagperuser'count'$i | awk '{print $1;}' )
#     output=$output" "$binnum
#     if test -z "$binnum"; then
#       output0=$output0" 0"
#     else
#       output0=$output0" "$binnum
#     fi
#   done
#   echo $output >> $tagcount
#   echo $output0 >> $tagcount'0'
# done < 'tag/pidfiltered.tagperusercounttop500_alphanumeric-noinsta'
# # #'tag/tagperusercounttop500'
# # 
# 
# sed '1d' $tagcount | cut -d " " -f 2- > $tagcount'number'
# sed '1d' $tagcount'0' | cut -d " " -f 2- > $tagcount'0''number'
# ##sed '1d' $tagcount | awk '{print $1;}' > tag/top500alphanumerictaglist
# # # normalize count
#  
#  
#  
# 
# python $SCRIPT_DIR/tagentropy.py '/l/vision/wang203/colorproj/flickr/'$GROUP'/tagmale/' pidfiltered.tagcount'0number'

maxidxnum='tagmale/pidfiltered.maxidxnum'
# echo 'num' > $maxidxnum
# i=0
# while read -r line
# do
#   i=$(($i+1))
#   echo $(head -n $i $tagcount'0number' | tail -n 1 | awk -v x=$line '{print $(x+3);}') >> $maxidxnum
# done < tagmale/pidfiltered.maxidx
tagentropybin='tagmale/tagentropybin'
echo 'tag totalnum entropy maxbin maxbinnum' > $tagentropybin
paste -d ' ' <(awk '{print $1" "$2;}' $tagcount| sed '1d') tagmale/pidfiltered.tagentropy tagmale/pidfiltered.maxidx <(sed '1d' $maxidxnum) >> $tagentropybin


python $SCRIPT_DIR/normcount.py 10 '/l/vision/wang203/colorproj/flickr/'$GROUP'/tagmale/'

paste -d ' ' tag/tag4binsum tagfemale/tag4binsum tagmale/tag4binsum > random.tag4binsum
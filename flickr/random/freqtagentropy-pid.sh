GROUP='random'
DIR=~/projects/hadoop-vision/scripts
FLICKR_DIR=${DIR}/../flickr
SCRIPT_DIR='/l/vision/wang203/colorproj/flickr/script'



# awk '$4==1||$4==2 {print $1;}' $GROUP.hadoop_output_photos | sort > tag/pidsort 
# ${FLICKR_DIR}/scripts/join_lookup.sh 1 2 tag/pidsort tag/$GROUP.photospidsort | awk '{print $1" "$20;}' | uniq > tag/pidtag
# mkdir tagfemale
# awk '$4==1 {print $1;}' $GROUP.hadoop_output_photos | sort > tagfemale/pidsort
# ${FLICKR_DIR}/scripts/join_lookup.sh 1 2 tagfemale/pidsort tag/$GROUP.photospidsort | awk '{print $1" "$20;}' | uniq > tagfemale/pidtag
# 
#### top 500

# awk '$4==1||$4==2 {print $2;}' test.2014-07-09_180432.10000.sample.hadoop-input | sort > tag/uidsort 

# ${FLICKR_DIR}/scripts/join_lookup.sh 1 1 tag/uidsort tag/$GROUP.photosuidsort | awk '{print $1" "$20;}' | uniq > tag/uidtag
# 
tagperuser='tag/pidfiltered.tagperuser'
# python mergeuidtag.py tag/uidtag $tagperuser
# 
# # echo 'pause'
# # read pause
# 
# tr ',' '\n' < $tagperuser | sed '/^$/d' | sort | uniq -c | sort -nrk1,1 > tag/taglist
####    grep  "^[a-zA-Z0-9 ]*$"  tag/taglist | head -n 500 > $tagperuser'count'top500'_alphanumeric'
# 

# awk '$4==1||$4==2 {print;}' $GROUP.hadoop_output_photos > tag/$GROUP.hadoop_output_photosgender
# 
# python $SCRIPT_DIR/toppidperbin-threading.py '/l/vision/wang203/colorproj/flickr/'$GROUP'/' tag/$GROUP.hadoop_output_photosgender
#  # 
#  for i in {1..65}; do
#    ${FLICKR_DIR}/scripts/join_lookup.sh 1 2 tag/toppid$i tag/$GROUP.photospidsort | awk '{print $2" "$20;}' | sort -k1 | uniq > tag/pidfiltered.uidtag$i
#    python mergeuidtag.py tag/pidfiltered.uidtag$i $tagperuser$i
#    tr ',' '\n' < $tagperuser$i | sed '/^$/d' | sort | uniq -c | sort -nrk1,1 > $tagperuser'count'$i
#    
#  done

# awk '$4==1 {print;}' $GROUP.hadoop_output_photos > tag/$GROUP.hadoop_output_photosgender.female
# 
# python $SCRIPT_DIR/toppidperbin-threading.py '/l/vision/wang203/colorproj/flickr/'$GROUP'/' tag/$GROUP.hadoop_output_photosgender.female
# 
# for i in {1..65}; do
#   ${FLICKR_DIR}/scripts/join_lookup.sh 1 2 tag/toppid$i tag/$GROUP.photospidsort | awk '{print $2" "$20;}' | uniq > tag/pidfiltered.uidtag$i
#   python mergeuidtag.py tag/pidfiltered.uidtag$i $tagperuser$i
#   tr ',' '\n' < $tagperuser$i | sed '/^$/d' | sort | uniq -c | sort -nrk1,1 > $tagperuser'count'$i
#   
# done








tagcount='tag/pidfiltered.tagcount'
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
# done < $tagperuser'count'top500'_alphanumeric-noinsta'
# 
# 
# #'tag/tagperusercounttop500'
# 
# ##sed '1d' $tagcount | cut -d " " -f 2- > $tagcount'number'
# sed '1d' $tagcount'0' | cut -d " " -f 2- > $tagcount'0''number'
# sed '1d' $tagcount | awk '{print $1;}' > tag/top500alphanumerictaglist
# ##normalize count
# 
# 
# 
# 
# python $SCRIPT_DIR/tagentropy.py '/l/vision/wang203/colorproj/flickr/'$GROUP'/tag/' pidfiltered.tagcount'0number'
# 
maxidxnum='tag/pidfiltered.maxidxnum-noinsta'
# echo 'num' > $maxidxnum
# i=0
# while read -r line
# do
#   i=$(($i+1))
#   echo $(head -n $i $tagcount'0number' | tail -n 1 | awk -v x=$line '{print $(x+3);}') >> $maxidxnum
# done < tag/pidfiltered.maxidx
tagentropybin='tag/tagentropybin'
echo 'tag totalnum entropy maxbin maxbinnum' > $tagentropybin
paste -d ' ' <(awk '{print $1" "$2;}' $tagcount| sed '1d') tag/pidfiltered.tagentropy tag/pidfiltered.maxidx <(sed '1d' $maxidxnum) >> $tagentropybin

python $SCRIPT_DIR/normcount.py 10 '/l/vision/wang203/colorproj/flickr/'$GROUP'/tag/'

GROUP='allpeople'
DIR=~/projects/hadoop-vision/scripts
FLICKR_DIR=${DIR}/../flickr
SCRIPT_DIR='/l/vision/wang203/colorproj/flickr/script'



# in $GROUP.photos column -- 5:pid 1:uid 3:gender 21:tags
awk '$4==1||$4==2 {print $1;}' $GROUP.hadoop_output | sort > tag/uidsort 
${FLICKR_DIR}/scripts/join_lookup.sh 1 1 tag/uidsort tag/$GROUP.photos uidsort | awk '{print $1" "$20;}' | uniq > tag/uidtag

tagperuser='tag/tagperuser'
# python mergeuidtag.py tag/uidtag $tagperuser

# echo 'pause'
# read pause

# tr ',' '\n' < $tagperuser | sed '/^$/d' | sort | uniq -c | sort -nrk1,1 |  head -n 500 > $tagperuser'count'top500

# awk '$4==1||$4==2 {print;}' $GROUP.hadoop_output > tag/$GROUP.hadoop_outputgender
# 
# python $SCRIPT_DIR/topuseridperbin.py '/l/vision/wang203/colorproj/flickr/'$GROUP'/' tag/$GROUP.hadoop_outputgender

# for i in {1..65}; do
#   ${FLICKR_DIR}/scripts/join_lookup.sh 1 1 tag/topuid$i tag/$GROUP.photosuidsort | awk '{print $1" "$20;}' | uniq > tag/uidtag$i
#   python mergeuidtag.py tag/uidtag$i $tagperuser$i
#   tr ',' '\n' < $tagperuser$i | sed '/^$/d' | sort | uniq -c | sort -nrk1,1 > $tagperuser'count'$i
#   
# done





tagcount='tag/tagcount'
echo 'tag totalnum bin1 ... bin65' > $tagcount
echo 'tag totalnum bin1 ... bin65' > $tagcount'0'
while read -r line
do
  targettag=$(echo $line | awk '{print $2;}')
  totalnum=$(echo $line | awk '{print $1;}')
  output=$targettag" "$totalnum
  output0=$targettag" "$totalnum
  for i in {1..65}; do
    binnum=$(grep '\ '$targettag'$' $tagperuser'count'$i | awk '{print $1;}' )
    output=$output" "$binnum
    if test -z "$binnum"; then
      output0=$output0" 0"
    else
      output0=$output0" "$binnum
    fi
  done
  echo $output >> $tagcount
  echo $output0 >> $tagcount'0'
done < $tagperuser'count'top500

sed '1d' $tagcount | cut -d " " -f 2- > $tagcount'number'

python $SCRIPT_DIR/tagentropy.py '/l/vision/wang203/colorproj/flickr/'$GROUP'/tag/' 'tagcountnumber'

maxidxnum='tag/maxidxnum'
echo 'num' > $maxidxnum
i=0
while read -r line
do
  i=$(($i+1))
  echo $(head -n $i $tagcount'0' | tail -n 1 | awk -v x=$line '{print $(x+3);}') >> $maxidxnum
done < tag/maxidx
tagentropybin='tag/tagentropybin'
echo 'tag totalnum entropy maxbin maxbinnum' > $tagentropybin
paste -d ' ' <(awk '{print $1" "$2;}' $tagcount| sed '1d') tag/tagentropy tag/maxidx <(sed '1d' $maxidxnum) | sort -g -k4 -k3 >> $tagentropybin

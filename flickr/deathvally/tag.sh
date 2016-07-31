GROUP='deathvally'
DIR=~/projects/hadoop-vision/scripts
FLICKR_DIR=${DIR}/../flickr

# sed 's/@N//g;' $GROUP.photos | sort -k1 > tag/$GROUP.photosuidsort
# # tag of female user with bin hist value > 0.1

tagperuserfemale="tag/"$GROUP.femaletagperuser
tagperusermale="tag/"$GROUP.maletagperuser
#find the pids contribute to the max bin value
# get uids first and then pids
for i in {12..13}; do
  awk -v x=$i '$4==1&&$(x+7)>0.1 {print $1;}' $GROUP.hadoop_output | sort > tag/femaleuidsort$i 
  ${FLICKR_DIR}/scripts/join_lookup.sh 1 1 tag/femaleuidsort$i tag/$GROUP.photosuidsort | awk '{print $1" "$21;}' | uniq > tag/femaleuidtag$i
  python mergeuidtag.py tag/femaleuidtag$i $tagperuserfemale$i 
  tr ',' '\n' < $tagperuserfemale$i | sed '/^$/d' | sort | uniq -c | sort -nrk1,1 > $tagperuserfemale'count'$i
  rm tag/femaleuidsort$i
  rm tag/femaleuidtag$i
  rm $tagperuserfemale$i

done

awk '$4==1 {print $1;}' $GROUP.hadoop_output | sort > tag/femaleuidsort 
${FLICKR_DIR}/scripts/join_lookup.sh 1 1 tag/femaleuidsort tag/$GROUP.photosuidsort | awk '{print $1" "$21;}' | uniq > tag/femaleuidtag
python mergeuidtag.py tag/femaleuidtag $tagperuserfemale
tr ',' '\n' < $tagperuserfemale | sed '/^$/d' | sort | uniq -c | sort -nrk1,1 > $tagperuserfemale'count'
rm tag/femaleuidsort
rm tag/femaleuidtag
rm $tagperuserfemale

# echo 'pause' 
# read pause

ratiofemaleuniq='tag/'$GROUP.tagratiofemaleuniq
ratiofemalefreq='tag/'$GROUP.tagratiofemalefreq
for i in {12..13}; do
  echo $i
  echo 'ratio    totalnum    binnum    tag' > $ratiofemaleuniq$i
  echo 'ratio    totalnum    binnum    tag' > $ratiofemalefreq$i
  while read -r line
  do
    targettag=$(echo $line | awk '{print $2;}')
    totalnum=$(grep '\ '$targettag'\b' $tagperuserfemale'count' | awk '{print $1;}' )
    binnum=$(echo $line | awk '{print $1;}')
    tagratio=$(echo $binnum/$totalnum | bc -l)

    if (( $(echo "$tagratio > 0.999999 " | bc -l) )); then      
      echo $tagratio' '$totalnum' '$binnum' '$targettag >> $ratiofemaleuniq$i
    elif (( $(echo "$tagratio < 1" | bc -l) )); then
      echo $tagratio' '$totalnum' '$binnum' '$targettag >> $ratiofemalefreq$i
    fi
  done < $tagperuserfemale'count'$i
done
# 
# 
# echo 'pause' 
# read pause





distincttagfemale='tag/'$GROUP.distincttagfemale
echo 'distinct tag of each bin' > $distincttagfemale
for i in {12..13}; do
  echo $i' '$(sort -nr -k1 $ratiofemalefreq$i | head -n 5) >> $distincttagfemale
done







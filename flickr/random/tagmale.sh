GROUP='allpeople'
DIR=~/projects/hadoop-vision/scripts
FLICKR_DIR=${DIR}/../flickr

# sed 's/@N//g;' $GROUP.photos | sort -k1 > tag/$GROUP.photosuidsort
# # tag of male user with bin hist value > 0.1

tagperusermale="tag/"$GROUP.maletagperuser
#find the pids contribute to the max bin value
# get uids first and then pids
for i in {1..65}; do
  awk -v x=$i '$4==2&&$(x+7)>0.1 {print $1;}' $GROUP.hadoop_output | sort > tag/maleuidsort$i 
  ${FLICKR_DIR}/scripts/join_lookup.sh 1 1 tag/maleuidsort$i tag/$GROUP.photosuidsort | awk '{print $1" "$20;}' | uniq > tag/maleuidtag$i
  python mergeuidtag.py tag/maleuidtag$i $tagperusermale$i 
  tr ',' '\n' < $tagperusermale$i | sed '/^$/d' | sort | uniq -c | sort -nrk1,1 > $tagperusermale'count'$i
  rm tag/maleuidtag$i
  rm $tagperusermale$i

done

echo 'pause' 
read pause




awk '$4==2 {print $1;}' $GROUP.hadoop_output | sort > tag/maleuidsort 
${FLICKR_DIR}/scripts/join_lookup.sh 1 1 tag/maleuidsort tag/$GROUP.photosuidsort | awk '{print $1" "$20;}' | uniq > tag/maleuidtag
python mergeuidtag.py tag/maleuidtag $tagperusermale
python mergeuidtag.py tag/maleuidtag $tagperusermaletr ',' '\n' < $tagperusermale | sed '/^$/d' | sort | uniq -c | sort -nrk1,1 > $tagperusermale'count'
rm tag/maleuidsort
rm tag/maleuidtag
rm $tagperusermale




ratiomaleuniq='tag/'$GROUP.tagratiomaleuniq
ratiomalefreq='tag/'$GROUP.tagratiomalefreq
for i in {1..65}; do
  echo $i
  echo 'ratio    totalnum    binnum    tag' > $ratiomaleuniq$i
  echo 'ratio    totalnum    binnum    tag' > $ratiomalefreq$i
  while read -r line
  do
    targettag=$(echo $line | awk '{print $2;}')
    totalnum=$(grep '\ '$targettag'\b' $tagperusermale'count' | awk '{print $1;}' )
    binnum=$(echo $line | awk '{print $1;}')
    tagratio=$(echo $binnum/$totalnum | bc -l)

    if (( $(echo "$tagratio > 0.999999 " | bc -l) )); then      
      echo $tagratio' '$totalnum' '$binnum' '$targettag >> $ratiomaleuniq$i
    elif (( $(echo "$tagratio < 1" | bc -l) )); then
      echo $tagratio' '$totalnum' '$binnum' '$targettag >> $ratiomalefreq$i
    fi
  done < $tagperusermale'count'$i
done
# 
# 
# echo 'pause' 
# read pause





distincttagmale='tag/'$GROUP.distincttagmale
echo 'distinct tag of each bin' > $distincttagmale
for i in {1..65}; do
  echo $i' '$(sort -nr -k1 $ratiomalefreq$i | head -n 5) >> $distincttagmale
done







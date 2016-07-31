# # pid of female image with bin hist value > 0.1
# pidfemale="tag/deathvallydistinctpidfemale"
# pidmale="tag/deathvallydistinctpidmale"
# #echo "pid-bin-hist-value-gt-0.1-female" > $pidfemale
# #echo "pid-bin-hist-value-gt-0.1-male" > $pidmale
# 
# #find the pids contribute to the max bin value
# for i in {1..65}; do
#   awk '$4==1&&$((i+7))>0.1 {print $1;}' deathvally.hadoop_output > $pidfemale$i
# done
# for i in {1..65}; do
#   awk '$4==2&&$((i+7))>0.1 {print $1;}' deathvally.hadoop_output > $pidmale$i
# done
# 
tagfemale="tag/deathvallydistincttagfemale"
# tagmale="tag/deathvallydistincttagmale"
# #echo "tag" > $fmaxtagfemale
# #echo "tag" > $fmaxtagmale
# for i in {1..65}; do
#   while read p; do
#     echo $(($p/100))
#     awk -v pid="$(($p/100))" '$1==pid&&$22~"" {print $22;}' tag/deathvally.photoscopy > $tagfemale$i
#   done < $pidfemale$i
# done
# 
# for i in {1..65}; do
#   while read p; do
#     echo $(($p/100))
#     awk -v pid="$(($p/100))" '$1==pid&&$22~"" {print $22;}' tag/deathvally.photoscopy > $tagmale$i
#   done < $pidmale$i
# done


#  count selected tags
# for i in {1..65}; do
#   tr ',' '\n' < $tagfemale$i | sed '/^$/d' | sort | uniq -c | sort -nrk1,1 > $tagfemale'count'$i
# #   tr ',' '\n' < $tagmale$i | sed '/^$/d' | sort | uniq -c | sort -nrk1,1 > $tagmale'count'$i
# done

# ratiofemale='tag/deathvallyratiofemale'
# for i in {1..65}; do
#   echo 'ratio    totalnum    binnum    tag' > $ratiofemale$i
#   while read -r line
#   do
#     #echo $line
#     targettag=$(echo $line | awk '{print $2;}')
#     #echo $targettag 
#     totalnum=$(grep '\ '$targettag'\b' tag/deathvallytagfemalecount | awk '{print $1;}' )
#     binnum=$(echo $line | awk '{print $1;}')
#     echo $(echo $binnum/$totalnum | bc -l)' '$totalnum' '$binnum' '$targettag >> $ratiofemale$i
#   done < tag/deathvallydistincttagfemalecount$i
# done


ratiofemale='tag/deathvallyratiofemale'
for i in {1..65}; do
  echo 'ratio    totalnum    binnum    tag' > $ratiofemale$i
  while read -r line
  do
    #echo $line
    targettag=$(echo $line | awk '{print $2;}')
    #echo $targettag 
    totalnum=$(grep '\ '$targettag'\b' tag/deathvallytagfemalecount | awk '{print $1;}' )
    binnum=$(echo $line | awk '{print $1;}')
    echo $(echo $binnum/$totalnum | bc -l)' '$totalnum' '$binnum' '$targettag >> $ratiofemale$i
  done < tag/deathvallydistincttagfemalecount$i
done

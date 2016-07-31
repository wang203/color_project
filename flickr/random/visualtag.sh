DIR=~/projects/hadoop-vision/scripts
FLICKR_DIR=${DIR}/../flickr
SCRIPT_DIR='/l/vision/wang203/colorproj/flickr/script'



tagperuser='tag/pidfiltered.tagperuser'

# to get least and largest entropy tag with accurate palmer hue
# lch2palmer_hue.sh
# python leastentropytag.py




# echo "<html><head><style>td{align:center;}
# </style></head><body></br><script src=sorttable.js></script><table class=\"sortable\" style=\"float:left;\">
# <tr><th>bin</th><th>hue</th><th>palmer</th><th>tag</th><th>entropy</th><th>percentage</th><th>totalnum</th></tr>" > tag500_gender.html
# while read -r line
# do
#   bin=$(echo $line | awk '{print $1;}')
#   tag=$(echo $line | awk '{print $2;}')
#   entropy=$(echo $line | awk '{print $3;}')
#   percentage=$(echo $line | awk '{print $4;}')
#   totalnum=$(echo $line | awk '{print $5;}')
#   hue=$(($bin*6-$bin/2))
#   palmer=$(($(($bin/8))*45+20))
#   
# 
#   # echo $targettag
#   echo "<tr><td>$bin</td><td style=\"background-color:hsl("$hue", 90%, 50%)\"></td><td style=\"background-color:hsl("$palmer",90%, 50%)\"></td><td><a style=\"display: inline\" href=\"visual/"$tag"100.html\">"$tag"</a></td><td>"$entropy"</td><td>"$percentage"</td><td>"$totalnum"</td></tr>" >> tag500_gender.html
# done < tag/tag4binsum
# echo "</table>" >> tag500_gender.html
# 
# echo "<table class=\"sortable\" style=\"float:left;\"><thead><tr><th>bin</th><th>hue</th><th>palmer</th><th>tag</th><th>entropy</th><th>percentage</th><th>totalnum</tr></thead><tbody>" >> tag500_gender.html
# while read -r line
# do
#   bin=$(echo $line | awk '{print $1;}')
#   tagfemale=$(echo $line | awk '{print $2;}')
#   entropyfemale=$(echo $line | awk '{print $3;}')
#   percentagefemale=$(echo $line | awk '{print $4;}')
#   totalnumfemale=$(echo $line | awk '{print $5;}')
#   huefemale=$(($bin*6-$bin/2))
#   palmerfemale=$(($(($bin/8))*45+20))
# 
#   # echo $targettag
#   echo "<tr><td>$bin</td><td style=\"background-color:hsl("$huefemale", 90%, 50%)\"></td><td style=\"background-color:hsl("$palmerfemale",90%, 50%)\"></td><td><a style=\"display: inline\" href=\"visual/"$tagfemale"100.html\">"$tagfemale"</a></td><td>"$entropyfemale"</td><td>"$percentagefemale"</td><td>"$totalnumfemale"</td></tr>" >> tag500_gender.html
# done < tagfemale/tag4binsum
# echo "</tbody></table>" >> tag500_gender.html
# 
# 
# echo "<table class=\"sortable\" style=\"float:left;\"><thead><tr><th>bin</th><th>hue</th><th>palmer</th><th>tag</th><th>entropy</th><th>percentage</th><th>totalnum</th></tr></thead><tbody>" >> tag500_gender.html
# while read -r line
# do
#   bin=$(echo $line | awk '{print $1;}')
#   tagmale=$(echo $line | awk '{print $2;}')
#   entropymale=$(echo $line | awk '{print $3;}')
#   percentagemale=$(echo $line | awk '{print $4;}')
#   totalnummale=$(echo $line | awk '{print $5;}')
#   huemale=$(($bin*6-$bin/2))
#   palmermale=$(($(($bin/8))*45+20))
# 
#   # echo $targettag
#   echo "<tr><td>$bin</td><td style=\"background-color:hsl("$huemale", 90%, 50%)\"></td><td style=\"background-color:hsl("$palmermale",90%, 50%)\"></td><td><a style=\"display: inline\" href=\"visual/"$tagmale"100.html\">"$tagmale"</a></td><td>"$entropymale"</td><td>"$percentagemale"</td><td>"$totalnummale"</td></tr>" >> tag500_gender.html
# done < tagmale/tag4binsum
# 
# 
# 
# echo "</tbody></table></body></html>" >> tag500_gender.html

############## tag page #################################
echo "<html><head><style>td{align:center;}
</style></head><body></br><script src=sorttable.js></script><table class=\"sortable\" style=\"float:left;\">
<tr><th>bin</th><th>hue</th><th>palmer</th><th>tag</th><th>entropy</th><th>percentage</th><th>totalnum</th></tr>" > tag500_gender.html
while read -r line
do
  bin=$(echo $line | awk '{print $1;}')
  tag=$(echo $line | awk '{print $2;}')
  palmer=$(($($bin)*45+20))

  # echo $targettag
  echo "<tr><td>$bin</td><td style=\"background-color:hsl("$hue", 90%, 50%)\"></td><td style=\"background-color:hsl("$palmer",90%, 50%)\"></td><td><a style=\"display: inline\" href=\"visual/"$tag"100.html\">"$tag"</a></td><td>"$entropy"</td><td>"$percentage"</td><td>"$totalnum"</td></tr>" >> tag500_gender.html
done < tag/tag4binsum
echo "</tbody></table></body></html>" >> tag500_gender.html

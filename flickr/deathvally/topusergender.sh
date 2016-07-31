GROUP='deathvally'
pythonDIR='/l/vision/wang203/colorproj/flickr/allpeople'
DIR='/l/vision/wang203/colorproj/flickr/'$GROUP
hist=$DIR/$GROUP'.hadoop_output'
genderhist=$hist'gender'
awk '$4==1||$4==2 {print;}' $hist > $genderhist
python $pythonDIR/topusergender.py $genderhist

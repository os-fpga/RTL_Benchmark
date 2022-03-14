#!/bin/bash
input="/home/users/ayyaz.ahmed/Desktop/cva6/Flist.cva6_synth"
while IFS= read -r line
do
#echo "$line"
FILE=/home/users/ayyaz.ahmed/Desktop/cva6/$line
echo $FILE
if [[ -f $FILE ]]
then
        cp $FILE /home/users/ayyaz.ahmed/Desktop/cva6/try
else
    echo “There are no files in the given path.”
fi
done < "$input"

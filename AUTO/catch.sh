#!/bin/bash 
# **********************************
# This file is used for catching the data from web and 
# filter the format of the data as "2016334 189"
# **********************************


TEMP=../temp/3d.xml
DEST=../temp/today.txt
DEST2=../temp/today2.txt

touch $TEMP

# Clean up the files of $DEST, $DEST2
:> $DEST
:> $DEST2

# Get the source data and store them in $TEMP.
# The format of the valid data is as following: 
# <row expect="2016334" opencode="1,8,9" opentime="2016-12-06 20:32:00"/>
curl http://f.apiplus.cn/fc3d.xml > $TEMP

#expect=`cat $TEMP | grep "expect" | awk -F '"' '{print $2 "\n"  $4}' `

# Store the data in the temp file, wait to be processed.
# The expect format of the data is "2016334 1,8,9" 
cat $TEMP | grep "expect" | awk -F '"' '{print $2 "\t"  $4}' >> $DEST
cat $DEST | awk -F ',' '{print $1$2$3}' >> $DEST2

rm -r $TEMP

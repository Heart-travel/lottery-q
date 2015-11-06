#!/bin/sh

DATABASE=../database
SOURCE=../temp/all_time.txt
OUTPUT=../temp/once.txt
TEMP=../temp/temp.txt

if [ -z $1 ]; then
	echo ERROR! Usage: ./once.sh [2003 - 2015]
	exit 0
fi

rm -f $TEMP
rm -rf $OUTPUT
echo "Generating all the number which only be shown once ..."
grep -nwr B $SOURCE | awk '{print $1}' | awk 'BEGIN {FS=":"} {print $2}' >> $OUTPUT
echo "Finish !"

for i in `cat $OUTPUT`
do
	grep -nwr $i $DATABASE >> $TEMP
done

grep -nrw $1 $TEMP 

#rm -f $TEMP

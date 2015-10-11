#!/bin/sh

echo "Generating all the number which only be shown once ..."
grep -nwr B new.txt | awk '{print $1}' | awk 'BEGIN {FS=":"} {print $2}'| tee b.txt
echo "Finish !"

for i in `cat b.txt`
do
	grep -nwr $i ./new
done

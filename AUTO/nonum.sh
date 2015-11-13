#!/bin/sh
SOURCE=../temp/all_time.txt
OUTPUT=../temp/nonum.txt

rm -rf $OUTPUT
echo All the number which has never been shown yet:
grep -nwr A $SOURCE | awk '{print $1}' | awk 'BEGIN {FS=":"} {print $2}' | tee $OUTPUT


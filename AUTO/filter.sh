#!/bin/sh

DATABASE=../database
OUTPUT=../temp/all_time.txt

TARGET=0
TAR_NUM=0

rm -rf $OUTPUT

for i in `seq 0 999`
do
	TARGET=`printf "%03d" $i`
	#echo $TARGET
	TAR_NUM=`grep -nwr $TARGET $DATABASE | wc -l`
	#echo TAR_NUM=$TAR_NUM
	if [ $TAR_NUM -eq 0 ]; then
		TAR_NUM=A
	elif [ $TAR_NUM -eq 1 ]; then
		TAR_NUM=B
	elif [ $TAR_NUM -eq 2 ]; then
		TAR_NUM=C
	elif [ $TAR_NUM -eq 3 ]; then
		TAR_NUM=D
	elif [ $TAR_NUM -eq 4 ]; then
		TAR_NUM=E
	elif [ $TAR_NUM -eq 5 ]; then
		TAR_NUM=F
	elif [ $TAR_NUM -eq 6 ]; then
		TAR_NUM=G
	elif [ $TAR_NUM -eq 7 ]; then
		TAR_NUM=H
	elif [ $TAR_NUM -eq 8 ]; then
		TAR_NUM=I
	elif [ $TAR_NUM -eq 9 ]; then
		TAR_NUM=J
	elif [ $TAR_NUM -eq 10 ]; then
		TAR_NUM=K
	elif [ $TAR_NUM -eq 11 ]; then
		TAR_NUM=L
	elif [ $TAR_NUM -eq 12 ]; then
		TAR_NUM=M
	elif [ $TAR_NUM -gt 12 ]; then
		TAR_NUM=Z
	fi
	#echo $TARGET $TAR_NUM | tee -a $OUTPUT
	echo $TARGET $TAR_NUM >> $OUTPUT
done

#!/bin/bash 

ROOTDIR=/home/zhaocg/Work/zhaocg/source/lottery
DATADIR=$ROOTDIR/database
TEMPDIR=$ROOTDIR/temp

TEMP=$TEMPDIR/3d.xml
DEST=$TEMPDIR/today.txt
DEST2=$TEMPDIR/today2.txt
CURRENTDATAFILE=$DATADIR/2016.txt
NONUMFILE=$TEMPDIR/nonum.txt
OUTPUT=$TEMPDIR/all_time.txt

# **********************************
# This file is used for catching the data from web and 
# filter the format of the data as "2016334 189"
# **********************************
CatchData(){
	
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
}

# **********************************
# 1) Get the date and happy number from $DEST2,
# 2) Write the happy number to database
# **********************************
WriteData(){
	YEAR=`tail -n 1 $CURRENTDATAFILE | awk '{print $1}'`
	T_YEAR=`head -n 1 $DEST2 | awk '{print $1}'`
	T_RESULT=`head -n 1 $DEST2 | awk '{print $2}'`
	rm -rf $NONUMFILE
	echo YEAR=$YEAR
	echo T_YEAR=$T_YEAR
	echo T_RESULT=$T_RESULT
	
	if [ "$YEAR" != "$T_YEAR" ]; then
		head -n 1 $DEST2 >> $CURRENTDATAFILE
		echo "No Equal, write $T_YEAR - $T_RESULT to 2016.txt"
		git add $CURRENTDATAFILE
		git commit -m `date "+%Y%m%d"`
		git push origin master
	else
		echo "Equal!"
	fi
}

Count(){
	TARGET=0
	TAR_NUM=0
	
	rm -rf $OUTPUT
	
	for i in `seq 0 999`
	do
		TARGET=`printf "%03d" $i`
		#echo $TARGET
		TAR_NUM=`grep -nwr $TARGET $DATADIR | wc -l`
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
}

CheckHappy(){
	rm -rf $NONUMFILE
	echo All the number which has never been shown yet:
	grep -nwr A $OUTPUT | awk '{print $1}' | awk 'BEGIN {FS=":"} {print $2}' | tee $NONUMFILE
}

cd $ROOTDIR/AUTO/
CatchData;
WriteData;
Count;
CheckHappy;

echo "********************************" >> $NONUMFILE
echo today: $T_YEAR - $T_RESULT >> $NONUMFILE
echo "********************************" >> $NONUMFILE
#mail -s "Lottory" zhaocg0422@thundersoft.com < ../temp/nonum.txt


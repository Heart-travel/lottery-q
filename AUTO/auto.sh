#!/bin/bash 

SOURCE=../temp/today2.txt
DEST=../database/2016.txt

cd /home/zhaocg/Work/zhaocg/source/lottery/AUTO/
source catch.sh

YEAR=`tail -n 1 ../database/2016.txt | awk '{print $1}'`
T_YEAR=`head -n 1 $SOURCE | awk '{print $1}'`
T_RESULT=`head -n 1 $SOURCE | awk '{print $2}'`
#rm -rf ../temp/today.txt
rm -rf ../temp/nonum.txt
echo YEAR=$YEAR
echo T_YEAR=$T_YEAR
echo T_RESULT=$T_RESULT

if [ "$YEAR" != "$T_YEAR" ]; then
	head -n 1 $SOURCE >> ../database/2016.txt
	echo "No Equal, write $T_YEAR - $T_RESULT to 2016.txt"
else
	echo "Equal!"
fi
source filter.sh
source nonum.sh
echo "********************************" >> ../temp/nonum.txt
echo today: $T_YEAR - $T_RESULT >> ../temp/nonum.txt
echo "********************************" >> ../temp/nonum.txt
#mail -s "Lottory" zhaocg0422@thundersoft.com < ../temp/nonum.txt

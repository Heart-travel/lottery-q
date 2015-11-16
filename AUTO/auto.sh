#!/bin/bash 

cd /home/zhaocg/source/lottery/AUTO/
source catch.sh

#cat ../temp/today.txt >> ../database/2015.txt
YEAR=`tail -n 1 ../database/2015.txt | awk '{print $1}'`
T_YEAR=`tail -n 1 ../temp/today.txt | awk '{print $1}'`
T_RESULT=`tail -n 1 ../temp/today.txt | awk '{print $2}'`
#rm -rf ../temp/today.txt
rm -rf ../temp/nonum.txt
#echo YEAR=$YEAR
#echo T_YEAR=$T_YEAR

if [ "$YEAR" != "$T_YEAR" ]; then
	cat ../temp/today.txt >> ../database/2015.txt
	echo "No Equal, write $T_YEAR - $T_RESULT to database"
else
	echo "Equal!"
fi
source filter.sh
source nonum.sh
echo "********************************" >> ../temp/nonum.txt
echo today: $T_YEAR - $T_RESULT >> ../temp/nonum.txt
echo "********************************" >> ../temp/nonum.txt
mail -s "Lottory" zhaocg0422@thundersoft.com < ../temp/nonum.txt

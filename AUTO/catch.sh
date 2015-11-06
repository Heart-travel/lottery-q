#!/bin/bash 

TEMP=../temp/3d.xml

touch $TEMP
curl http://f.apiplus.cn/fc3d.xml > $TEMP

#expect="2015302"opencode="1,2,0"

expect=`cat $TEMP | awk ' FS="><"{print $7}' | awk  -F\" '{print $2}'`
opencode=`cat $TEMP | awk ' FS="><"{print $8}' | awk  -F\" '{print $2}' | awk -F\, '{print $1 $2 $3}'`

echo $expect $opencode
rm -r $TEMP

#!/bin/bash 

curl http://f.apiplus.cn/fc3d.xml > ../temp/3d.xml

#expect="2015302"opencode="1,2,0"

expect=`cat ../temp/3d.xml | awk ' FS="><"{print $7}' | awk  -F\" '{print $2}'`
opencode=`cat ../temp/3d.xml | awk ' FS="><"{print $8}' | awk  -F\" '{print $2}' | awk -F\, '{print $1 $2 $3}'`

echo $expect $opencode

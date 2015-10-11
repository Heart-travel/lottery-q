#!/bin/sh
echo All the number which has never been shown yet:
grep -nwr A ./new.txt | awk '{print $1}' | awk 'BEGIN {FS=":"} {print $2}' | tee nonum.txt


#!/bin/bash
case "$2" in
"") echo "Usage: ${0##*/} <update register from Xpress Software> <MM>"; exit 1;;
esac
time sed 's/\"\,\"/\jwhrg/g' < "$1" | 
grep -v 'ElectorDOB' | 
sed 's/^\"//' | 
sed 's/\"$//' | 
sed 's/\,//g' | 
sed 's/jwhrg/\,/g' >awk2.tmp
time awk -v p="pds.csv" -f ../b4up14.awk awk2.tmp >importedupdate$2.csv
#srm -sr awk2.tmp

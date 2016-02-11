#!/bin/bash
case "$2" in
"") echo "Usage: ${0##*/} <update register from Xpress Software> <MM>"; exit 1;;
esac
time {
grep -v 'ElectorDOB' "$1" | 
sed 's/\xa0/ /g' |
php ../maketab.php |
awk -v p="pds.csv" -f ../b4up14.awk |
sed 's/\.//g' >importedupdate$2.csv
wc -l importedupdate$2.csv
wc -l pds.csv
}

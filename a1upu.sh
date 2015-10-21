#!/bin/bash
case "$2" in
"") echo "Usage: ${0##*/} <update register from Idox Elections> <MM>"; exit 1;;
esac
time {
# drop Microsoft linefeeds
sed $'s/\r$//' $1 |
# keep the comma delimiters we want
sed 's/\"\,\"/\jwhrg/g' |
# drop the leading quote
sed 's/^\"//' |
# drop the trailing quote
sed 's/\"$//' |
# drop all content commas
sed 's/\,//g' |
# put back the delimiters
sed 's/jwhrg/\,/g' |
sort -u |
awk -f ../titlecase2.awk -f ../b1upu.awk >importedupdate$2.csv
}

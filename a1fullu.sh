#!/bin/bash
case "$1" in
"") echo "Usage: ${0##*/} <full register from Idox Elections>"; exit 1;;
esac
PDFILE="pds.csv"
time {
# take out the headers
grep -v ',"U",' $1 |
# drop Microsoft linefeeds
sed $'s/\r$//' |
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
awk -v p="pds.csv" -f ../titlecase2.awk -f ../b1fullu.awk >importedfullregister.csv
}

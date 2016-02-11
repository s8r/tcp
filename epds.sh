#!/bin/bash
case "$1" in
"") echo "Extract PDs from tab or comma delimited input. Usage: ${0##*/} <file>"; exit 1;;
esac
echo "extract $1 to comma-delimited rawpds.csv"
time {
delimiter="\t"
s=$(head -n 1 "$1")
echo $s
if [[ $s == *","* ]]
then
  delimiter=","
fi
echo "input delimiter is $delimiter"
# merge field-1 with the present working directory name
awk -v p="$PWD" 'BEGIN {FS="'$delimiter'";OFS=","} ; { print p,$1 }' "$1" |
# reduce the number of records to process
sort -u |
# remove all quote marks
sed 's/\"//g' |
# change all slash to comma
sed 's/\//,/g' |
# change all space dash space to comma
sed 's/\ \-\ /\,/g' |
# remove the hard-coded directory tree
sed 's/^\,home\,john\,electreg\,lads\,//' |
# drop Microsoft linefeeds
sed $'s/\r$//' |
# drop any stray header line(s)
grep -v 'Elector' |
grep -v 'Date' > rawpds.csv
wc -l rawpds.csv
}

#!/bin/bash
case "$1" in
"") echo "test awk. Usage: ${0##*/} <full register Halarose EROS>"; exit 1;;
esac
PDFILE="pds.csv"
echo "pp50 extract"
time {
# take out the headers
time tail -n +3 $1 |
#grep -v ',"U",' $1 | \
#grep -v 'Elector Number' | \
#grep -v 'Date Published' | \
# drop Microsoft linefeeds
sed $'s/\r$//' |
# keep the comma delimiters we want
sed 's/\"\,\"/\jwhrg/g' |
# drop the leading quote
sed 's/^\"//' |
# drop the trailing quote
sed 's/\"$//' |
# drop all content commas
sed 's/\,/jwhrg/g' |
# put back the delimiters as tabs
sed 's/jwhrg/\t/g' |
awk -v p="pds.csv" -f ../titlecase2.awk -f ../b5fullpp.awk  >importedfullregister.csv
}

#!/bin/bash
case "$1" in
"") echo "Usage: ${0##*/} <update register Halarose EROS concatenated>"; exit 1;;
esac
PDFILE="pds.csv"
echo "pp18 extract"
time {
#grep -v ',"U",' $1 |
#grep -v 'Elector Number' |
#grep -v 'Date Published' |
# drop Microsoft linefeeds
sed $'s/\r$//' "$1" |
# keep the comma delimiters we want
sed 's/\"\,\"/\jwhrg/g' |
# drop the leading quote
sed 's/^\"//' |
# drop the trailing quote
sed 's/\"$//' |
# either comma-delimited
sed 's/\,/\t/g' |
# or quote-comma delimited, put back the delimiters as tabs
sed 's/jwhrg/\t/g' |
awk -v p="pds.csv" -f ../titlecase2.awk -f ../b5upp.awk  >importedupdate.csv
sort --field-separator=',' -k1,5 -k40 importedfullregister.csv importedupdate.csv |
sort -u --field-separator=',' -k1,5 |
grep -v ',1 Delete 00' >importedcurrentregister.csv
}

#!/bin/bash
case "$1" in
"") echo "Usage: ${0##*/} <full register from Idox Elections>"; exit 1;;
esac
PDFILE="pds.csv"
time {
# take out the headers
grep -v '","U","' $1 |
grep -v 'Franchise Flag' |
grep -v 'Date Published' |
grep -v 'PostCode' |
sed 's/\xa0/ /g' |
php ../maketab.php |
awk -v p="pds.csv" -f ../titlecase2.awk -f ../b1fullu.awk |
sed 's/\.//g' >importedfullregister.csv
wc -l importedfullregister.csv
wc -l pds.csv
grep BLANK importedfullregister.csv
../constituencies.sh importedfullregister.csv
echo "wc -l full.csv"
}

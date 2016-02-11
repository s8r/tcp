#!/bin/bash
case "$1" in
"") echo "Usage: ${0##*/} <full register from Xpress Software>"; exit 1;;
esac

echo  ${0##*/} "$1 data extract started"
time {
head -n 1 $1 |
grep Forename |
#type 1 if there's a surname+forename else 0.
wc -l >type

# take out the headers
grep -v 'Franchise Flag' "$1" |
grep -v 'Date Published' |
grep -v 'Elector Number' |
grep -v 'PostCode' |
sed 's/\xa0/ /g' >awk1.tmp
php ../maketab.php <awk1.tmp >awk2.tmp
awk -v p="pds.csv" -f ../titlecase2.awk -f ../b4full14.awk awk2.tmp |
sed 's/\.//g' >importedfullregister.csv
wc -l importedfullregister.csv
wc -l pds.csv
grep BLANK importedfullregister.csv
../constituencies.sh importedfullregister.csv
echo "wc -l full.csv"
rm awk?.tmp
}

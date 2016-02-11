#!/bin/bash
case "$1" in
"") echo "Usage: ${0##*/} <update register Bedford concatenated>"; exit 1;;
esac
PDFILE="pds.csv"
echo "Bedford extract"
time {
grep -v FranchiseMarker "$1" |
sed 's/\xa0/ /g' |
php ../maketab.php |
awk -v p=$PDFILE -f ../titlecase2.awk -f ../b7uppd.awk |
sed 's/\.//g' >importedupdateall.csv
wc -l importedupdateall.csv
wc -l pds.csv
sort -t$'\t' -k1,4 -k5,5n -k40 importedfullregister.csv importedupdateall.csv |
# The next line retains just one command from the merged file.
# In priority order, this is by type 1: delete, 2: amend, 3: create and 9: original full register entry.
# If there are multiple commands of the same type, the most recent takes priority (ie. by descending month)
sort -u -t$'\t' -k1,4 -k5,5n |
grep -v '1 Delete 00' >importedcurrentregister.csv
# now reconcile the update
../reconciliation.sh
}
# and cycle the old current in place of the full for subsequent months

#!/bin/bash
case "$2" in
"") echo "Usage: ${0##*/} <update register from Idox Elections> <MM>"; exit 1;;
esac
time {
grep -v 'Franchise Flag' "$1" |
grep -v 'Date Published' |
sed 's/\xa0/ /g' |
php ../maketab.php |
sort -u |
awk -f ../titlecase2.awk -f ../b1upu.awk >importedupdate$2.csv
}

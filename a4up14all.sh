#!/bin/bash
case "$1" in
"") echo "Usage: ${0##*/} <update register from Xpress Software>"; exit 1;;
esac
echo processing all updates...
time {
../a4up14 "$1" all
sort --field-separator=',' -k1,4 -k5,5n -k40 importedfullregister.csv importedupdateall.csv |
sort -u --field-separator=',' -k1,4 -k5,5n |
grep -v ',1 Delete 00' >importedcurrentregister.csv

#srm -sr importedupdateall.csv
#srm -sr i1.tmp
#srm -sr i2.tmp
}

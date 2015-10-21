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

# drop Microsoft linefeed
sed $'s/\r$//' < "$1" |
# drop the header line(s)
grep -v 'Elector Number Suffix' |
awk -v p="pds.csv" -f ../b4full14.awk >importedfullregister.csv
wc -l importedfullregister.csv
wc -l pds.csv
}
echo ${0##*/} "$1 ended"

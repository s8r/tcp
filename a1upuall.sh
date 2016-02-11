#!/bin/bash
case "$1" in
"") echo "Usage: ${0##*/} <update register from Idox Elections>"; exit 1;;
esac
echo processing all updates...
../a1upu.sh "$1" all
sort -t$'\t' -k1,5 -k40 importedfullregister.csv importedupdateall.csv |
sort -u -t$'\t' -k1,5 |
grep -v '1 Delete 00' >importedcurrentregister.csv
../reconciliation.sh

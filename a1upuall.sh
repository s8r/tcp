#!/bin/bash
echo processing all updates...
../a1upu.sh '*.ASC' all
sort --field-separator=',' -k1,5 -k40 importedfullregister.csv importedupdateall.csv |
sort -u --field-separator=',' -k1,5 |
grep -v ',1 Delete 00' >importedcurrentregister.csv

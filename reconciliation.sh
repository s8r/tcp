#!/bin/bash
awk -f ../s1extract.awk importedfullregister.csv |
sort -t$'\t' -k7,8 -k6,6 -k5,5n >property.csv
cut -f 1-2,7-16  property.csv | sort -t$'\t' -k4,5 -u >street.csv
cut -f 1-2,7-16  property.csv | sort -t$'\t' -k3,3 -k5,5 -u >postcode.csv
# now reconcile the update
grep '3 Create ' importedupdateall.csv | cut -f 3-5 | sort >c.csv
grep '2 Amend ' importedupdateall.csv | cut -f 3-5 | sort >a.csv
grep '1 Delete ' importedupdateall.csv | cut -f 3-5 | sort >d.csv
cut -f 3-5 importedfullregister.csv | sort >f.csv
cut -f 3-5 importedcurrentregister.csv | sort >n.csv
echo "----------------------------------------"
SEC="$(wc -l f.csv  | cut -d " " -f 1)"
EEC="$(wc -l n.csv  | cut -d " " -f 1)"
echo "starting elector count ${SEC}"
echo "  ending elector count ${EEC}"
echo "----------------------------------------"
# Deletes
sort -u d.csv f.csv >dfsu.csv
DC="$(wc -l d.csv  | cut -d " " -f 1)"
echo "failed deletes? - the number of delete commands is ${DC}"
DFC="$(diff f.csv dfsu.csv | grep ">" | wc -l  | cut -d " " -f 1)"
echo "of which the number with no keymatch on the register is ${DFC}"
diff f.csv dfsu.csv | grep ">" | cut -d " " -f 2 #| sed 's/,0//' |  sed 's/,/-/' | sed 's/,/\//'
echo "Corresponding create instructions are:"
comm -1 -2 d.csv c.csv
echo "----------------------------------------"
# Amends
comm -1 -2 a.csv c.csv >acmatch.csv
sort a.csv f.csv >afs.csv
uniq afs.csv >afsu.csv
sort a.csv n.csv >ans.csv
uniq ans.csv >ansu.csv
echo -n "the number of amends is "
wc -l a.csv
echo -n "of which the number originally on the register is "
diff afs.csv afsu.csv | grep "<" | wc -l
echo "Corresponding create instructions are:"
cat acmatch.csv
echo "The following have been treated as additional Create instructions"
cat afs.csv acmatch.csv | sort >afsm.csv
#diff afs.csv afsmu.csv | grep "<" | cut -d " " -f 2 > afd.csv
diff afs.csv afsu.csv | grep "<" | cut -d " " -f 2 > afd.csv
diff a.csv afd.csv | grep "<" | cut -d " " -f 2 > afdd.csv
diff afdd.csv acmatch.csv | grep "<" | cut -d " " -f 2 #| sed 's/,0//' |  sed 's/,/-/' | sed 's/,/\//'
echo "----------------------------------------"
# Creates
sort c.csv f.csv >cf.csv
uniq cf.csv >cfsu.csv
echo -n "failed creates? - the number of create commands is "
wc -l c.csv
echo -n "of which the number pre-existing on the register is "
diff cf.csv cfsu.csv | grep "<" | wc -l
diff cf.csv cfsu.csv | grep "<" | cut -d " " -f 2 #| sed 's/,0//' |  sed 's/,/-/' | sed 's/,/\//'
echo "----------------------------------------"
../constituencies.sh "importedcurrentregister.csv"
rm a*.csv
rm c*.csv
rm d*.csv
rm f.csv
rm n.csv

#!/bin/bash
case "$1" in
"") echo "Usage: ${0##*/} <imported register to display by constituency"; exit 1;;
esac
cut -f 1-2 "$1" >t1
sort -u t1 >t2
sed 's/\t/\\t/' <t2 >t3
sed "s/^/grep \$\'\^/" <t3 >t4
echo "#!/bin/bash" >t.sh
sed "s/$/\' $1 | wc -l/" <t4 >>t.sh
echo wc -l $1 >>t.sh
chmod +x t.sh
cat t2
./t.sh
rm t?

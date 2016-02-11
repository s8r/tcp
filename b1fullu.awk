# Takes a full Idox Elections file
# invoke awk -v p="pds.csv" -f ../titlecase.awk -f ../b1fullu.awk infile >outfile

BEGIN {
  FS="\t" 
  OFS="\t"
  while (getline < "pds.csv")
  {
    split($0,ft,",");
    ladv1=ft[1];
    ladv2=ft[2];
    ladv3=ft[3];
    pdv=ft[4];
    constituencyv=ft[5];
    lad[pdv]=ladv1;
    constituency[pdv]=constituencyv;
    }
  close(p);
}

{
enopd = $1
enola = lad[enopd]
enoc = constituency[enopd]
eno = $2
enosuffix = ""
yyyymmcreated = ""
yyyymmchanged = ""
yyyymmdeleted = ""
updateyyyymm = ""
updatecramde = ""
uprn = ""
flags = $3




optout = ""
uprn = ""

if (index($5, "(z) ")) {
  optout = "Z"
  electorsurname = surname(substr($5,5))
}
else {
  electorsurname = surname($5)
}

electortitle = "" 
split($6,ft," ");
electorforename = titlecase(ft[1])
electorinitials = titlecase(ft[2] ft[3] ft[4] ft[5] ft[6] )

electorsuffix = ""
electorattaindate = titlecase($4)
electordob = ""
addressprefix = titlecase($16)
addressnumber = titlecase($15)
addressstreetname titlecase($17)
addresspostcode = $22
if ($22 == $7) address1 = $7
else address1 = titlecase($7)
if ($22 == $8) address2 = $8
else address2 = titlecase($8)
if ($22 == $9) address3 = $9
else address3 = titlecase($9)
if ($22 == $10) address4 = $10
else address4 = titlecase($10)
if ($22 == $11) address5 = $11
else address5 = titlecase($11)
if ($22 == $12) address6 = $12
else address6 = titlecase($12)
if ($22 == $13) address7 = $13
else address7 = titlecase($13)
if ($22 == $14) address8 = $14
else address8 = titlecase($14)
address9 = ""
faddress1 = ""
faddress2 = ""
faddress3 = ""
faddress4 = ""
faddress5 = ""
faddress6 = ""
control = "9 Full register entry"


print enola, enoc, enopd, eno, enosuffix,
flags, optout, electortitle, electorforename, electorinitials, electorsurname, electorsuffix, electorattaindate, electordob,
addressprefix, addressnumber, addressstreetname, addresspostcode,
address1, address2, address3, address4, address5, address6, address7, address8, address9,
faddress1, faddress2, faddress3, faddress4, faddress5, faddress6,
yyyymmcreated, yyyymmchanged, yyyymmdeleted, updateyyyymm, updatecramde, uprn, control

}
#
# the sort -u will put out the LOWEST-SORTED control
# so we selectively drop 9 Full register,
# then 3 Created during the year,
# then 2 Amended, with the reverse date ordering the most recvent to the lowest
# then the Deletes, unstamped so grep can get rid of them.
# the final sort -u will do all the creates, amends and deletes for the year.
#

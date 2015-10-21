# Takes a full pp50-format Halarose EROS file
# invoke awk -v p="pds.csv" -f ../titlecase2.awk -f ../b5fullpp.awk infile >outfile

BEGIN {
  FS="\t" 
  OFS=","
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

# "PD"
# "ENO"
# "Status"
# "Title"
# "First Names"
# "Initials"
# "Surname"
# "Suffix"
# "Date of Attainment"
# "Franchise Flag"    10
# "Address 1"
# "Address 2"
# "Address 3"
# "Address 4"
# "Address 5"
# "Address 6"
# "Address 7"
# "Address 8"
# "Address 9"
# "Postcode"   20
# "Opt Out"

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
uprn = $3
flags = $10
optout = ""
uprn = ""
if (length($21) >= 2) uprn = $21
else optout = $21
if (match($7, "(z) ")) {
  optout = "Z"
  electorsurname = surname(substr($7,5))
}
else {
  electorsurname = surname($7)
}
electortitle = $4
electorforename = titlecase($5)
electorinitials = titlecase($6)
electorsuffix = titlecase($8)
electorattaindate = $9
electordob = ""
addressprefix = ""
addressnumber = ""
addressstreetname ""
addresspostcode = $20
if ($20 == $11) address1 = $11
else address1 = titlecase($11)
if ($20 == $12) address2 = $12
else address2 = titlecase($12)
if ($20 == $13) address3 = $13
else address3 = titlecase($13)
if ($20 == $14) address4 = $14
else address4 = titlecase($14)
if ($20 == $15) address5 = $15
else address5 = titlecase($15)
if ($20 == $16) address6 = $16
else address6 = titlecase($16)
if ($20 == $17) address7 = $17
else address7 = titlecase($17)
if ($20 == $18) address8 = $18
else address8 = titlecase($18)
if ($20 == $19) address9 = $19
else address9 = titlecase($19)
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



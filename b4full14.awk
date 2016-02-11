# Takes a full Xpress Software file
# invoke awk -v p="pds.csv" -f ../b4full14.awk infile >outfile

BEGIN {
  FS="\t" 
  OFS="\t"
  while (getline < p)
  {
    split($0,ft,",")
    ladv1=ft[1]
    ladv2=ft[2]
    ladv3=ft[3]
    pdv=ft[4]
    constituencyv=ft[5]
    lad[pdv]=ladv1
    constituency[pdv]=constituencyv
    }
  close(p)
  t="type"
  while (getline < t)
  {
    type=$1
  }
  close(t)
}
{
enopd = $1
enola = lad[enopd]
enoc = constituency[enopd]
eno = $2
enosuffix = $3
yyyymmcreated = ""
yyyymmchanged = ""
yyyymmdeleted = ""
updateyyyymm = ""
updatecramde = ""
uprn = ""
flags = $4
optout = ""
electortitle = "" 
electorsuffix = ""
electorattaindate = ""
electordob = $5
addressprefix = ""
addressnumber = ""
addressstreetname ""
address7 = ""
address8 = ""
address9 = ""
faddress1 = ""
faddress2 = ""
faddress3 = ""
faddress4 = ""
faddress5 = ""
faddress6 = ""

#14 field record, type=1
#Elector Number Prefix
#Elector Number
#Elector Number Suffix
#Elector Markers
#Elector DOB
#Elector Surname
#Elector Forename
#08 PostCode
#Address1
#Address2
#Address3
#Address4
#Address5
#Address6

#13 field record, type=0
#Elector Number Prefix
#Elector Number
#Elector Number Suffix
#Elector Markers
#Elector DOB
#Elector Name
#07 PostCode
#Address1
#Address2
#Address3
#Address4
#Address5
#Address6

if (type == 1) {
  split($7,ft," ");
  electorforename = ft[1]
  electorinitials = ft[2] ft[3] ft[4] ft[5] ft[6] 
  electorsurname = surname($6)
  addresspostcode = $8
  address1 = $9
  address2 = $10
  address3 = $11
  address4 = $12
  address5 = $13
  address6 = $14
}
else {
  split($6,ft," ");
  electorforename = ft[2]
  electorinitials = ft[3] ft[4] ft[5] ft[6] ft[7] 
  electorsurname = surname(ft[1])
  addresspostcode = $7
  address1 = $8
  address2 = $9
  address3 = $10
  address4 = $11
  address5 = $12
  address6 = $13
}
control = "9 Full register entry"
if (enola != "") {
print enola, enoc, enopd, eno, enosuffix,
flags, optout, electortitle, electorforename, electorinitials, electorsurname, electorsuffix, electorattaindate, electordob,
addressprefix, addressnumber, addressstreetname, addresspostcode,
address1, address2, address3, address4, address5, address6, address7, address8, address9,
faddress1, faddress2, faddress3, faddress4, faddress5, faddress6,
yyyymmcreated, yyyymmchanged, yyyymmdeleted, updateyyyymm, updatecramde, uprn, control
}
else {
  print "BLANK!", enoc, enopd, eno, enosuffix,
flags, optout, electortitle, electorforename, electorinitials, electorsurname, electorsuffix, electorattaindate, electordob,
addressprefix, addressnumber, addressstreetname, addresspostcode,
address1, address2, address3, address4, address5, address6, address7, address8, address9,
faddress1, faddress2, faddress3, faddress4, faddress5, faddress6,
yyyymmcreated, yyyymmchanged, yyyymmdeleted, updateyyyymm, updatecramde, uprn, control
}
}
#
# the sort -u will put out the LOWEST-SORTED control
# so we selectively drop 9 Full register,
# then 3 Created during the year,
# then 2 Amended, with the reverse date ordering the most recvent to the lowest
# then the Deletes, unstamped so grep can get rid of them.
# the final sort -u will do all the creates, amends and deletes for the year.
#

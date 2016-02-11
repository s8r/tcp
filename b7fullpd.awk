# Takes a full pp50-format Halarose EROS file
# invoke awk -v p="pds.csv" -f ../titlecase2.awk -f ../b5fullpp.awk infile >outfile

BEGIN {
  FS="\t" 
  OFS="\t"
  p="pds.csv"
  while (getline < p)
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
  close(p)
  t="type"
  while (getline < t)
  {
    type=$1
  }
  close(t)
}

# PDCode
# RollNo
# ElectorTitle
# ElectorSurname
# ElectorForename        5
# ElectorMiddleName
# AttainersDOB
# FranchiseMarker
# RegisteredAddress1
# RegisteredAddress2    10 
# RegisteredAddress3
# RegisteredAddress4
# RegisteredAddress5
# RegisteredAddress6
# PostCode              15
# Euro
# Parl
# County
# Ward
# SubHouse              20
# House


#   BA1
#   5.000
#   
#   Przybylo
#5  MacIej
#   
#   
#   G
#   7 ARUN CLOSE
#10 BEDFORD
#   
#   
#   
#   
#15 MK41 7AD
#   EASTERN
#   BEDFORD
#   MAYORAL
#   BRICKHILL
#20   
#   

{
#print $1 , $2 , $3 , $4
#print length($1) , length($2) , length($3) , length($4)

enopd = $1
enola = lad[enopd]
enoc = constituency[enopd]
split($2,a, ".")
eno = a[1]
enosuffix = a[2]
yyyymmcreated = ""
yyyymmchanged = ""
yyyymmdeleted = ""
updateyyyymm = ""
updatecramde = ""
uprn = ""
electordob = ""
addressprefix = ""
addressnumber = ""
addressstreetname ""
faddress1 = ""
faddress2 = ""
faddress3 = ""
faddress4 = ""
faddress5 = ""
faddress6 = ""
optout = ""

  flags = $8
  electorsurname = surname($4)
  electortitle = titlecase($3)
  electorforename = titlecase($5)
  electorinitials = titlecase($6)
  electorsuffix = ""
  electorattaindate = $7
  addresspostcode = $15
  if ($15 == $9) address1 = $9
  else address1 = titlecase($9)
  if ($15 == $10) address2 = $10
  else address2 = titlecase($10)
  if ($15 == $11) address3 = $11
  else address3 = titlecase($11)
  if ($15 == $12) address4 = $12
  else address4 = titlecase($12)
  if ($15 == $13) address5 = $13
  else address5 = titlecase($13)
  if ($15 == $14) address6 = $14
  else address6 = titlecase($14)
  control = "9 Full register entry"

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

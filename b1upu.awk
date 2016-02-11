# Takes an update Idox Elections file
# invoke awk -v p="pds.csv" -f ../titlecase.awk -f ../b1upu.awk infile >outfile

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
act = substr($3,1,1) # plus minus or equal
actmmm =  substr($3,2) # the month XXX
flags = $4

optout = ""
uprn = ""

if (index($6, "(z) ")) {
  optout = "Z"
  electorsurname = surname(substr($6,5))
}
else {
  electorsurname = surname($6)
}

split($7,ft," ");
electorforename = titlecase(ft[1])
electorinitials = titlecase(ft[2] ft[3] ft[4] ft[5] ft[6] )

electorsuffix = ""
electorattaindate = titlecase($5)
electordob = ""
addressprefix = titlecase($17)
addressnumber = titlecase($16)
addressstreetname titlecase($18)
addresspostcode = $23
if ($23 == $8) address1 = $8
else address1 = titlecase($8)
if ($23 == $9) address2 = $9
else address2 = titlecase($9)
if ($23 == $10) address3 = $10
else address3 = titlecase($10)
if ($23 == $11) address4 = $11
else address4 = titlecase($11)
if ($23 == $12) address5 = $12
else address5 = titlecase($12)
if ($23 == $13) address6 = $13
else address6 = titlecase($13)
if ($23 == $14) address7 = $14
else address7 = titlecase($14)
if ($23 == $15) address8 = $15
else address8 = titlecase($15)
address9 = ""
faddress1 = ""
faddress2 = ""
faddress3 = ""
faddress4 = ""
faddress5 = ""
faddress6 = ""
actmm = "00"
if (actmmm == "Jan") actmm = "90"
if (actmmm == "Feb") actmm = "89"
if (actmmm == "Mar") actmm = "88"
if (actmmm == "Apr") actmm = "87"
if (actmmm == "May") actmm = "86"
if (actmmm == "Jun") actmm = "85"
if (actmmm == "Jul") actmm = "84"
if (actmmm == "Aug") actmm = "83"
if (actmmm == "Sep") actmm = "82"
if (actmmm == "Oct") actmm = "81"
if (actmmm == "Nov") actmm = "80"
if (actmmm == "Dec") actmm = "79"

actx = "Query"
if (act == "+") actx = "3 Create " actmm
if (act == "-") actx = "1 Delete 00"
if (act == "=") actx = "2 Amend " actmm

print enola, enoc, enopd, eno, enosuffix,
flags, optout, electortitle, electorforename, electorinitials, electorsurname, electorsuffix, electorattaindate, electordob,
addressprefix, addressnumber, addressstreetname, addresspostcode,
address1, address2, address3, address4, address5, address6, address7, address8, address9,
faddress1, faddress2, faddress3, faddress4, faddress5, faddress6,
yyyymmcreated, yyyymmchanged, yyyymmdeleted, updateyyyymm, updatecramde, uprn, actx
}

# Takes an update Halarose EROS file
# invoke awk -v p="pds.csv" -f ../titlecase.awk -f ../b5fuppu.awk infile >outfile

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

  if (index($0, "Ref: "))
    i = 1
  else if (index($0, "Accession:")) {
    split($0,a, " ")
    switch (a[3]) {
    case "jan":
      actmm="90";
      break
    case "feb":
      actmm="89";
      break
    case "mar":
      actmm="88";
      break
    case "apr":
      actmm="87";
      break
    case "may":
      actmm="86";
      break
    case "jun":
      actmm="85";
      break
    case "jul":
      actmm="84";
      break
    case "aug":
      actmm="83";
      break
    case "sep":
      actmm="82";
      break
    case "oct":
      actmm="81";
      break
    case "nov":
      actmm="80";
      break
    case "dec":
      actmm="79";
      break
    default:
      actmm="99";
      break
      }
    }
  else {
  
  
#     ChangeTypeID = D,M,N
#     PDCode
#     RollNo
#     ElectorTitle
# 5   ElectorSurname
#     ElectorForename
#     ElectorMiddleName
#     DOB
#     FranchiseMarker
# 10   RegisteredAddress1
#     RegisteredAddress2
#     RegisteredAddress3
#     RegisteredAddress4
#     RegisteredAddress5
# 15  RegisteredAddress6
#     PostCode
#     Euro
#     Parl
#     County
# 20  Ward
#     SubHouse
#     House
#     MONTH INDICATOR eg update02feb.csv




enopd = $2
enola = lad[enopd]
enoc = constituency[enopd]
split($3,a, ".")
eno = a[1]
enosuffix = a[2]
yyyymmcreated = ""
yyyymmchanged = ""
yyyymmdeleted = ""
updateyyyymm = ""
updatecramde = ""
uprn = ""
flags = $9
optout = ""
electortitle = titlecase($4)
electorforename = titlecase($6)
electorinitials = titlecase($7)
electorsurname = surname($5)
electorsuffix = ""
electorattaindate = ""
electordob = $8
addressprefix = ""
addressnumber = ""
addressstreetname ""
addresspostcode = $16
if ($16 == $10) address1 = $10
else address1 = titlecase($10)
if ($16 == $11) address2 = $11
else address2 = titlecase($11)
if ($16 == $12) address3 = $12
else address3 = titlecase($12)
if ($16 == $13) address4 = $13
else address4 = titlecase($13)
if ($16 == $14) address5 = $14
else address5 = titlecase($14)
if ($16 == $15) address6 = $15
else address6 = titlecase($15)
faddress1 = ""
faddress2 = ""
faddress3 = ""
faddress4 = ""
faddress5 = ""
faddress6 = ""


actx = "Query"
if ($1 == "N") actx = "3 Create " actmm
if ($1 == "D") actx = "1 Delete 00"
if ($1 == "M") actx = "2 Amend " actmm


control = actx

if (enola != "") {
print enola, enoc, enopd, eno, enosuffix,
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


}

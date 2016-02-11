# Takes an update Xpress Software file
# invoke awk -v p="pds.csv" -f ../b4up14.awk infile >outfile

BEGIN {
  FS="\t" 
  OFS="\t"
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
  close(p);
}

{

#     CompanyName
#     CompanyOPCSRef
#     DistrictRef
#     StreetName
# 5   PropertyAddress1
#     PropertyAddress2
#     PropertyAddress3
#     PropertyAddress4
#     PropertyAddress5
# 10  PropertyPostCode
#     PropertyAddressPrefix
#     PropertyAddressNumber
#     ElectorNumber
#     ElectorForename
# 15  ElectorSurname
#     ElectorDOB
#     ElectorCreatedMonth
#     ElectorChangedMonth
#     ElectorDeletedMonth
# 20  MarkersRegisterText
#     RecordCount
#     RecordTotal
#     CurrentRegisterMonth"

  enopd = $3
  enola = lad[enopd]
  enoc = constituency[enopd]
  
  split($13,ft,"-"); # commonly ABC1-12/1 or ABC1-12)
  if (ft[3] != "") { # but this is a nasty valid example KD-2/2-289/1 Mid Devon, March update 2016.
    ft[1] = ft[1] ft[2]
    ft[2] = ft[3]
    ft[3] = ""
  }
  if (ft[2] == "") ft[2] = $13 # I can think of no instance, this would be invalid
  a = ft[2]
  split(a,ft,"/");
  if (ft[2] == "") ft[2] = "0" # I standardize on having suffix 0 instead of null on an importedfile
  eno = ft[1]
  enosuffix = ft[2]

  yyyymmcreated = ""
  yyyymmchanged = ""
  yyyymmdeleted = ""
  updateyyyymm = ""
  updatecramde = ""
  uprn = ""
    
  actmm = "00"
  actmmm =  substr($23,1,3) # the month XXX
  
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
  
  act = ""
  j = (91 - actmm)
  if ($17 > 0) act = "+"
  # we should switch create+amend to be a create
  if (($18 > 0) && ($17 != $18)) act = "=" # amends take precedence over creates (but will also create if need be)
  # and we ought to force 000 to be an amend, apparently.
  if (($17 == 0) && ($18 == 0) && ($19 == 0)) act = "="
  if (($19 > 0)) act = "-" # deletes take precedence over amends and creates
  
  flags = $20
  optout = ""
  electortitle = "" 
  
  split($14,ft," ");
  electorforename = ft[1]
  electorinitials = ft[2] ft[3] ft[4] ft[5] ft[6] 
  electorsurname = $15
  
  electorsuffix = ""
  electorattaindate = ""
  electordob = $16
  addressprefix = $11
  addressnumber = $12
  addressstreetname $4
  addresspostcode = $10
  address1 = $5
  address2 = $6
  address3 = $7
  address4 = $8
  address5 = $9
  address6 = ""
  address7 = ""
  address8 = ""
  address9 = ""
  faddress1 = ""
  faddress2 = ""
  faddress3 = ""
  faddress4 = ""
  faddress5 = ""
  faddress6 = ""
  
  actx = "Query"
  if (act == "+") actx = "3 Create " actmm
  if (act == "=") actx = "2 Amend " actmm
  if (act == "-") actx = "1 Delete 00"
  
  if ((act == "-") && ($17 == $19))  actx = "Query" # drop create+delete instructions
  
  
  
  if (actx != "Query") {
  print enola, enoc, enopd, eno, enosuffix,
  flags, optout, electortitle, electorforename, electorinitials, electorsurname, electorsuffix, electorattaindate, electordob,
  addressprefix, addressnumber, addressstreetname, addresspostcode,
  address1, address2, address3, address4, address5, address6, address7, address8, address9,
  faddress1, faddress2, faddress3, faddress4, faddress5, faddress6,
  yyyymmcreated, yyyymmchanged, yyyymmdeleted, updateyyyymm, updatecramde, uprn, actx
  }
}

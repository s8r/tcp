# Property extract
# invoke awk -f ../s1extract.awk import

BEGIN {
  FS="\t" 
  OFS="\t"
}

{
  enola = $1
  enoc = $2
  enopd = $3
  eno = $4
  enosuffix = $5          # 05
  flags = $6
  optout = $7
  electortitle = $8
  electorforename = $9
  electorinitials = $10   # 10
  electorsurname = $11
  electorsuffix = $12
  electorattaindate = $13
  electordob = $14
  addressprefix   = $15   # 15
  addressnumber = $16
  addressstreetname = $17
  addresspostcode = $18
  address1 = $19
  address2      = $20     # 20
  address3 = $21
  address4 = $22
  address5 = $23
  address6 = $24
  address7      = $25     # 25
  address8 = $26
  address9 = $27
  faddress1 = $28
  faddress2 = $29
  faddress3      = $30    # 30
  faddress4 = $31
  faddress5 = $32
  faddress6 = $33
  yyyymmcreated = $34
  yyyymmchanged = $35     # 35
  yyyymmdeleted = $36
  updateyyyymm = $37
  updatecramde = $38
  uprn = $39
  actx      = $40         # 40
  a1 = address1;
  holda1 = address1;
  
  # find a house number or a house name, on the raw address.
  
  i = match(a1, /^([[:digit:]][[:graph:]]*)[[:space:]]*(.*)/, b);
  
  
#  gsub (/[0-9]/, "", address1);
#  gsub (/^[:digit:]/, "", address1);
#  print address1;
# either we have an addressnumber, if there's number space street, or we have an addressstreetname
  if (i == 0) {
    addressstreetname = a1;
    address1 = address2;
    address2 = address3;
    address3 = address4;
    address4 = address5;
    address5 = address6;
    address6 = address7;
    address7 = address8;
    address8 = address9;
    address9 = "";
  }
  else {
    addressnumber = b[1];
    address1 = b[2];
  }

  
  #handle Flat 1, 5 Ladybank,
  # that needs trim external spaces from lots of fields
# sub(/ +$/,"",variable)  # trailing
# sub(/^ +/,"",variable)  # leading 
  
  # eg Dunroaming, 123 Tolver Place - take the house number off the street name.
  # Dunroaming is already in the addressstreetname
  a1 = address1;
  i = match(a1, /^([[:digit:]][[:graph:]]*)[[:space:]]*(.*)/, b);
  if (i > 0) {
    addressnumber = b[1];
    address1 = b[2];
    if (address1 == "") {
      address1 = address2;
      address2 = address3;
      address3 = address4;
      address4 = address5;
      address5 = address6;
      address6 = address7;
      address7 = address8;
      address8 = address9;
      address9 = "";
    }
  }

  
  # eg 2 Rosewood Court,124 Glascote Road  
  # 2 is already in the addressnumber and we'll put the whole original first line in addressstreetname
  a1 = address2;
  i = match(a1, /^([[:digit:]][[:graph:]]*)[[:space:]]*(.*)/, b);
  if (i > 0) {
    addressnumber = b[1];
    address1 = b[2];
    addressstreetname = holda1;
    address2 = address3;
    address3 = address4;
    address4 = address5;
    address5 = address6;
    address6 = address7;
    address7 = address8;
    address8 = address9;
    address9 = "";
  }

  if (address1 != "" || address2 != "" || address3 != "" || address4 != "" || address5 != "" || address6 != "" || address7 != "" || address8 != "" || address9 != "") {
    print enola, enoc, enopd,
    addressprefix, addressnumber, addressstreetname, addresspostcode,
    address1, address2, address3, address4, address5, address6, address7, address8, address9;
  }

# enola
# enoc
# enopd
# addressprefix
# addressnumber          #5
# addressstreetname
# addresspostcode
# address1
# address2
# address3               #10
# address4
# address5
# address6
# address7
# address8               #15
# address9
}

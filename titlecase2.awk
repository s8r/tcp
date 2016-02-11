
function surnamepart(string) {
# a part that might need an uppercase first letter, and another again after Mc or O'
    if (index(" de di von ",string))
      return string
    else {
      string = toupper(substr(string, 1, 1)) substr(string,2)
      if ((substr(string, 1, 2) == "Mc") || (substr(string, 1, 2) == "O`") || (substr(string, 1, 2) == "O'") || (substr(string, 1, 2) == "D'")  || (substr(string, 1, 2) == "D`"))
	string = substr(string,1,2) toupper(substr(string, 3, 1)) substr(string,4)
    }
    return string
}

function surname(string) {
# Only surnames get this treatment but it's the same approach as titlecase(string)
  if (string == "")
    return string
  j = split(tolower(string), d, " ")
  s = surnamepart(d[1])
  for (i = 2; i <= j; i++)
    s = s " " surnamepart(d[i])
  j = split(s, d, "-")
  s = surnamepart(d[1])
  for (i = 2; i <= j; i++)
    s = s "-" surnamepart(d[i])
  return s
}

function spart(string) {
# A part that needs an uppercase first letter
    string = toupper(substr(string, 1, 1)) substr(string,2)
    return string
}

function titlecase(string) {
# any field like Forenames, Address4 can come here and be legitimized
  if (string == "")
    return string
  j = split(tolower(string), d, " ")
  s = spart(d[1])
  for (i = 2; i <= j; i++)
    s = s " " spart(d[i])
  j = split(s, d, "-")
  s = spart(d[1])
  for (i = 2; i <= j; i++)
    s = s "-" spart(d[i])
  return s
}


# consider fullstops and two-letter initials together.

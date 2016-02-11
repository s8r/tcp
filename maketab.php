<?php

  ##############################################################################################################
  # This program turns variants of quote-comma delimited files to safe quote-free comma-free tab-delimited files
  # Drop quotes and embedded commas, fix Microsoft end-of-lines and hard spaces, turn comma-delimiters into tabs
  ##############################################################################################################
  #	
  #	invoke as "php maketab.php <csv"
  #	
  #	Copyright 2015 John Harris +447940174990 s@s8r.uk
  #	
  #	This program is free software: you can redistribute it and/or modify
  #	it under the terms of the GNU General Public License as published by
  #	the Free Software Foundation, either version 3 of the License, or
  #	(at your option) any later version.
  #	
  #	This program is distributed in the hope that it will be useful,
  #	but WITHOUT ANY WARRANTY; without even the implied warranty of
  #	MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
  #	GNU General Public License for more details.
  #	
  #	You should have received a copy of the GNU General Public License
  #	along with this program.  If not, see <http://www.gnu.org/licenses/>.
  #	
  #############################################################################################################

  define("QUOTE", chr(34)); 		# these are constants, conventionally uppercase names
  define("TAB", chr(9));
  define("COMMA", chr(44));
  define("HARDSPACE", chr(160));
  define("CR", chr(13));
  define("SPACE", chr(32));
  while (FALSE !== ($line = fgets(STDIN)))  {
    $arr = str_split($line); 		# one character at a time of the input line including the end-of-line marker
    $out = ""; 				# the built-up line to write
    $qc = 0; 				# quote count found so far within the input line
    $tc = 0; 				# tab count found so far within the input line
    for($i = 0, $arrc = count($arr); $i < $arrc; $i++) {
      $c = $arr[$i];
      if ($c == TAB) {
        $tc++;
      }
      if ($c == HARDSPACE) {
        $c = SPACE;
      }
      if ($c == QUOTE || $c == CR) {
        $qc++;				# count one quote of a quote pair (CR is only ever at the array end) and drop the quote or CR
      } elseif ($c != COMMA) {		# everything left except commas (but including original tabs) gets sent out
	$out .= $c;
  } elseif (($qc > 0 && !($qc & 1)) || ($qc == 0 && $tc == 0)) {
  	$out .= TAB;			# and if there were non-embedded comma-delimiters they get turned to tabs here
      }
    }
    print $out;
  }
?>

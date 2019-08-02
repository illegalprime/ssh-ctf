{ lib, runCommand, fetchurl, figlet
, flag, message
}:
with lib;
let
  doh = fetchurl {
    url = "http://www.figlet.org/fonts/doh.flf";
    sha256 = "16ndrqrrgs8zp7p6bld62ksmqzng58cvjqc2kq6liw2ma57n490m";
  };

  characters = map ({ fst, snd }:
    "<(${figlet}/bin/figlet -f ${doh} ${snd} | sed 's/${snd}/${fst}/g')")
    (zipLists (stringToCharacters flag) (stringToCharacters message));
in
runCommand "art-data" {} ''
  mkdir -p $out/ctf
  cd $out/ctf
  ${figlet}/bin/figlet -f ${doh} -w 1000 'Congratulations! You Found Art!' >> art
  paste ${concatStringsSep " " characters} >> art
''

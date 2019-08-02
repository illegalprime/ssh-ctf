{ stdenv, jdk, perl, flag-file }:

stdenv.mkDerivation {
  name = "gnu-bf-program";
  src = ./shortbf.java;
  unpackPhase = "true";

  buildPhase = ''
    set -x
    cat $src > shortbf.java
    perl -pe 's/[^[:ascii:]]//g' ${flag-file} > input

    javac shortbf.java
    java shortbf input > flag.bf

    sed -i 's/-/gdown/g' flag.bf
    sed -i 's/+/gup/g' flag.bf
    sed -i 's/</gno/g' flag.bf
    sed -i 's/>/gyes/g' flag.bf
    sed -i 's/]/gthere/g' flag.bf
    sed -i 's/\[/ghere/g' flag.bf
    sed -i 's/\./gold/g' flag.bf
    sed -i 's/,/gnu/g' flag.bf
    set +x
  '';

  installPhase = ''
    cat flag.bf > $out
  '';

  nativeBuildInputs = [
    jdk
    perl
  ];
}

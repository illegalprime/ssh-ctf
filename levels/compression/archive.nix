{ stdenv, zip, gnutar
, ctf-flag-format, flag }:

stdenv.mkDerivation {
  name = "ctf-compression-archive";
  src = ctf-flag-format flag;
  unpackPhase = "true";

  buildPhase = ''
    cat $src > flag.mp3

    zip -r flag.zip flag.mp3

    tar -cvf flag.tar flag.zip

    base64 flag.tar > flag.base64
  '';

  installPhase = ''
    mkdir -p $out/ctf
    cp flag.base64 $out/ctf/
  '';

  nativeBuildInputs = [
    zip
    gnutar
  ];
}

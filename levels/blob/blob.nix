{ stdenv
, flag
}:

stdenv.mkDerivation rec {
  name = "blob-${version}";
  version = "0.1.0";
  src = ./blob.c;
  unpackPhase = "true";

  buildPhase = ''
    gcc -o blob -D 'FLAG="${flag}"' -g ${./blob.c} \
      -Wall -Wextra -Werror -pedantic
  '';

  installPhase = ''
    mkdir -p $out/bin
    mv blob $out/bin/
  '';
}

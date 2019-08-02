{ stdenv, openssl }:

stdenv.mkDerivation {
  name = "interpretation-data";
  src = ./.;

  buildInputs = [ openssl ];

  buildPhase = ''
    $CC ${./prog2.c} \
      -lssl -lcrypto \
      -O2 \
      -Wall -Werror -Wextra -pedantic \
      -o prog2
  '';

  dontPatchELF = true;

  installPhase = ''
    mkdir -p $out/ctf

    cp ${./prog1.sh} $out/ctf/prog1.sh

    patchelf --set-interpreter /lib/interpret/this prog2
    cp prog2 $out/ctf/prog2
  '';
}

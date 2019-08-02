{ stdenv, fetchFromGitHub, cmake, readline }:

stdenv.mkDerivation rec {
  name = "bfi-${version}";
  version = "0.1";

  src = fetchFromGitHub {
    owner = "FilippoRanza";
    repo = "bfi";
    rev = "0d58023c042288d822b0d8f24f78b34898e70102";
    sha256 = "0xw5jdy9vpk0srn5anxffgnhnn8f6dl810sn83fpiashy02nr6j5";
  };

  nativeBuildInputs = [
    cmake
  ];

  buildInputs = [
    readline
  ];

  installPhase = ''
    mkdir -p $out/bin
    mv bfi $out/bin/
  '';
}

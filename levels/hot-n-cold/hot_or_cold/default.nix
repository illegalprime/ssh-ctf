{ lib, rustPlatform, runtimeShell
, key, flag
}:
with lib;

rustPlatform.buildRustPackage {
  name = "hot_or_cold";
  src = ./.;
  cargoSha256 = "0jacm96l1gw9nxwavqi1x4669cg6lzy9hr18zjpwlcyb3qkw9z7f";

  # try to hide the key
  configurePhase = let
    alphabet = [
      "a" "b" "c" "d" "e" "f" "g" "h" "i" "j" "k" "l" "m"
      "n" "o" "p" "q" "r" "s" "t" "u" "v" "w" "x" "y" "z"
    ];
    to_idx = t: (findFirst ({ i, c }: c == t) {}
      (imap0 (i: c: { inherit i c; }) alphabet)).i;
    key_idx = concatStringsSep "\n"
      (map (c: toString (to_idx c)) (stringToCharacters key));
  in ''
    echo ${escapeShellArg key_idx} > secret
    ${runtimeShell} ./vigenere.sh ${key} ${flag} > flag.enc
  '';
}

{ config, pkgs, lib, ... }:
let cfg = config.ctf.levels.interpretation; in
{
  ctf.levels.interpretation.image = pkgs.ctf-make-docker {
    name = "interpretation";

    contents = with pkgs; let
      data = pkgs.callPackage ./data {};
    in [
      binutils-unwrapped
      glibc
      glibc.bin
      data
      (ctf-encrypt-flag {
        flag = ctf-flag-format cfg.flag;
        key-file = runCommand "interpretation-key-file" {} ''
          ${glibc}/lib/ld-linux-x86-64.so.2 ${data}/ctf/prog2 | tail -1 > $out
        '';
      })
    ];

    banner = ''
      ┏━━
      ┇  Level ${toString cfg.number}: Up to Interpretation
      ┇  Useful commands: readelf, ldd
      ┗━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━
    '';
  };
}

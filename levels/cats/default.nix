{ config, pkgs, lib, ... }:
let cfg = config.ctf.levels.cats; in
{
  ctf.levels.cats.image = pkgs.ctf-make-docker {
    name = "cats";

    contents = lib.singleton (pkgs.runCommand "cats-data" {} ''
      mkdir -p $out/ctf
      cat ${pkgs.ctf-flag-format cfg.flag} > $out/ctf/-
    '');

    banner = ''
      ┏━━
      ┇  Level ${toString cfg.number}: Cats
      ┇  Useful commands: ls, cat
      ┗━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━
    '';
  };
}

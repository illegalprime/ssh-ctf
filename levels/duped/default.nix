{ config, pkgs, lib, ... }:
let cfg = config.ctf.levels.duped; in
{
  ctf.levels.duped.image = pkgs.ctf-make-docker {
    name = "duped";

    contents = lib.singleton (pkgs.runCommand "duped-data" {} ''
      mkdir -p $out/ctf
      split -l 18000 ${./duped.txt}
      cat xaa <(echo '┇   ${cfg.flag}   ┇') xab > $out/ctf/'duped!'
    '');

    banner = ''
      ┏━━
      ┇  Level ${toString cfg.number}: Duped!
      ┇  Useful commands: sort, uniq
      ┗━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━
    '';
  };
}

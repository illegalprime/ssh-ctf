{ config, pkgs, lib, ... }:
let cfg = config.ctf.levels.art; in
{
  ctf.levels.art.image = pkgs.ctf-make-docker {
    name = "art";

    contents = with pkgs; [
      (callPackage ./art.nix {
        inherit (cfg) flag;
        message = "theworkofartwasinsideyouallalong";
      })
      gnused
    ];

    banner = ''
      ┏━━
      ┇  Level ${toString cfg.number}: Art
      ┇  Useful commands: less, sed, uniq, tr
      ┗━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━
    '';
  };
}

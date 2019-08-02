{ config, pkgs, lib, ... }:
let cfg = config.ctf.levels.blob; in
{
  ctf.levels.blob.image = pkgs.ctf-make-docker {
    name = "blob";

    contents = with pkgs; [
      (callPackage ./blob.nix { inherit (cfg) flag; })
      binutils-unwrapped
      gnugrep
      which
    ];

    banner = ''
      ┏━━
      ┇  Level ${toString cfg.number}: Blob
      ┇  Useful commands: strings, grep, blob
      ┗━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━
    '';
  };
}

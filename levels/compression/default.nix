{ config, pkgs, lib, ... }:
let cfg = config.ctf.levels.compression; in
{
  ctf.levels.compression.image = pkgs.ctf-make-docker {
    name = "compression";

    contents = [
      (pkgs.callPackage ./archive.nix { inherit (cfg) flag; })
    ] ++ (with pkgs; [
      file
      gnutar
      unzip
    ]);

    banner = ''
      ┏━━
      ┇  Level ${toString cfg.number}: Middle Out Compression
      ┇  Commands: file, unzip, tar, base64, ...
      ┗━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━
    '';
  };
}

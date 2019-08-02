{ config, pkgs, lib, ... }:
let
  cfg = config.ctf.levels.braingnu;

  program = pkgs.callPackage ./program.nix {
    flag-file = pkgs.ctf-flag-format cfg.flag;
  };

  tree = pkgs.runCommand "braingnu-data" {} ''
    mkdir -p $out/ctf
    cat ${./braingnu-specification} > $out/ctf/'Braingnu Specification'
    cat ${program} > $out/ctf/flag.bg
  '';
in
{
  ctf.levels.braingnu.image = pkgs.ctf-make-docker {
    name = "braingnu";

    contents = [ tree ] ++ (with pkgs; [
      gawk
      gnused
      (callPackage ./brainfuck.nix {})
    ]);

    banner = ''
      ┏━━
      ┇  Level ${toString cfg.number}: Braingnu
      ┇  Useful commands: sed, bfi
      ┗━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━
    '';
  };
}

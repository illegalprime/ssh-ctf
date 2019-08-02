{ config, pkgs, lib, ... }:
let cfg = config.ctf.levels.questions; in
{
  ctf.levels.questions.image = pkgs.ctf-make-docker {
    name = "questions";

    contents = with pkgs; [
      (callPackage ./riddler.nix {})
      (callPackage ./encrypt-flag.nix {
        inherit (cfg) flag;
        key = "hiya"; # TODO: real one
      })
      openssl
    ];

    banner = ''
      ┏━━
      ┇  Level ${toString cfg.number}: Questions
      ┇
      ┇  The flag is encrypted in 'flag.enc',
      ┇  run 'riddler' and answer all the prompts
      ┇  correctly to recover the encryption key!
      ┇  Then decrypt with:
      ┇
      ┇  decrypt KEY flag.enc
      ┗━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━
    '';
  };
}

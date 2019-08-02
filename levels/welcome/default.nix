{ config, pkgs, lib, ... }:
{
  ctf.levels.welcome.image = pkgs.ctf-make-docker {
    name = "welcome";

    banner = ''
      ┏━━
      ┇  Welcome to the CTF!
      ┇  SSH into the next level via:
      ┇
      ┇  ssh level2@${config.ctf.external-host}
      ┇
      ┇  the password is
      ┇  ${config.ctf.levels.welcome.flag}
      ┇
      ┇  There you'll be greeted with a challenge,
      ┇  solving the challenge grants you a "flag"
      ┇  which is just the password to level3!
      ┇  Keep SSH-ing to higher levels and win!
      ┗━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━
    '';
  };
}

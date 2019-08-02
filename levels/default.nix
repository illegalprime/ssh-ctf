{ pkgs, config, ... }:
{
  imports = [
    ./welcome
    ./cats
    ./braingnu
    ./compression
    ./hot-n-cold
    ./duped
    ./blob
    ./art
    ./questions
    ./video
    ./interpretation
  ];

  ctf.level-order = [
    "welcome"
    "cats"
    "braingnu"
    "compression"
    "hot-n-cold"
    "duped"
    "blob"
    "art"
    "questions"
    "video"
    "interpretation"
  ];

  ctf.entrypoint = {
    user = "play";
    password = "start";
  };
}

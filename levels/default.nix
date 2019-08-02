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
  ];

  ctf.entrypoint = {
    user = "play";
    password = "start";
  };
}

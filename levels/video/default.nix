{ config, pkgs, lib, ... }:
let cfg = config.ctf.levels.video; in
let video = pkgs.callPackage ./video.nix { inherit (cfg) flag; }; in
{
  ctf.levels.video.image = pkgs.ctf-make-docker {
    name = "video";

    contents = with pkgs; [
      nmap
      netcat
    ];

    banner = ''
      ┏━━
      ┇  Level ${toString cfg.number}: Video Streaming
      ┇  Useful commands: nmap, nc, vlc
      ┗━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━
    '';
  };

  systemd.services.ctf-video = {
    description = "Video Server for CTF";
    enable = true;
    after = [ "network.target" ];
    wantedBy = [ "multi-user.target" ];
    serviceConfig = {
      ExecStart = let
        tcpserver = "${pkgs.ucspi-tcp}/bin/tcpserver";
      in "${tcpserver} -v 0.0.0.0 2023 cat ${video}/flag.mp4";
      User = "nobody";
      Group = "nobody";
    };
  };

  networking.firewall.allowedTCPPorts = [ 2023 ];
}

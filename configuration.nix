{ config, ... }:
{
  imports = [
    ./modules
    ./levels
    ./pkgs
  ];

  # Enable Docker
  virtualisation.docker.enable = true;

  # Enable SSH
  services.openssh.enable = true;
  services.openssh.extraConfig = ''
    PrintLastLog no
  '';

  # Advertise ourselves as 192.168.56.101
  ctf.external-host = "192.168.56.101";
}

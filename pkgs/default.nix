{ ... }:
{
  # add our custom packages
  nixpkgs.overlays = [
    (self: super: {
      ctf-shell = super.callPackage ./ctf-shell.nix {};
      ctf-make-docker = super.callPackage ./make-docker.nix {};
      ctf-flag-format = super.callPackage ./flag-format.nix {};
    })
  ];
}

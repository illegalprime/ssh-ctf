{ lib, ... }:
with lib;
{
  options.ctf = {
    external-host = mkOption {
      description = "public host name for SSH access";
      type = types.str;
    };
  };
}

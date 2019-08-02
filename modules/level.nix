{ pkgs, lib, config, ... }:
with lib;
with types;
let
  flags = builtins.fromJSON (builtins.readFile ../flags.json);

  level = submodule {
    options = {
      image = mkOption {
        type = package;
        description = "the docker container to use";
      };
      number = mkOption {
        type = int;
        default = -1;
        description = "the order this level shows up in";
      };
      flag = mkOption {
        type = str;
        default = "00000000000000000000000000000000";
        description = "the password to the next level in plain text";
      };
    };
  };

  level_by_number = n: findFirst (l: l.value.number == n) null
    (mapAttrsToList nameValuePair config.ctf.levels);
in
{
  options.ctf = {
    levels = mkOption {
      description = "Levels in the CTF";
      type = attrsOf level;
    };

    level-order = mkOption {
      description = "order of all the levels by name";
      type = listOf str;
    };

    entrypoint.user = mkOption {
      type = str;
      description = "name of the SSH user for the first level";
    };

    entrypoint.password = mkOption {
      type = str;
      description = "password of the SSH user for the first level";
    };
  };

  config = mkMerge [
    {
      # load all the docker images on boot
      systemd.services.load-docker-images = {
        enable = true;
        description = "Load Nix Docker Images";
        wantedBy = ["multi-user.target"];
        requires = ["docker.service"];
        after = ["docker.service"];
        path = with pkgs; [ docker ];
        script = ''
          docker system prune --force --all
        '' + (concatStrings (map (level: ''
          docker load < ${level.image}
        '') (attrValues config.ctf.levels)));
      };

      # make a user for every level
      users.users = mapAttrs' (name: level: {
        name = level.ssh-name or "level${toString level.number}";
        value = {
          # set the password to the previous flag
          password = elemAt flags (level.number - 1);
          # make a shell to load the level's image
          shell = pkgs.ctf-shell { inherit level name; };
          # give permission to run docker
          extraGroups = [ "docker" ];
        };
      }) config.ctf.levels;

      ctf.levels = listToAttrs (imap1 (i: name: {
        inherit name;
        value = {
          # automatic level numbers
          number = i;
          # set the flag to the password of the next level
          flag = elemAt flags i;
        };
      }) config.ctf.level-order);

      assertions = [
        {
          # check that the user didn't misspell anything in level-order
          assertion = all
            (name: hasAttrByPath [ name "image" ] config.ctf.levels)
            config.ctf.level-order;
          message = "unknown level in level-order";
        }
        {
          assertion = unique config.ctf.level-order == config.ctf.level-order;
          message = "levels in level-order can only appear once";
        }
      ];
    }
    {
      # make fancier first level entry user
      users.users."${config.ctf.entrypoint.user}" = {
        password = config.ctf.entrypoint.password;
        extraGroups = [ "docker" ];
        shell = let
          entrypoint = level_by_number 1;
        in pkgs.ctf-shell {
          inherit (entrypoint) name;
          level = entrypoint.value;
        };
      };
    }
  ];
}

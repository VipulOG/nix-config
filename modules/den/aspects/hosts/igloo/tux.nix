{den, ...}: {
  den.aspects.igloo.tux = {
    includes = [
      den.aspects.igloo.tux.syncthing
      den.aspects.igloo.tux.restic
    ];

    nixos = {
      sops.secrets.tux-password = {
        neededForUsers = true;
      };
    };

    user = {config, ...}: {
      hashedPasswordFile = config.sops.secrets.tux-password.path;
    };

    homeManager = {
      home.stateVersion = "26.05";
    };

    persist = {
      preserve.users.tux.directories = [
        {
          directory = "DCIM";
          mode = "0700";
        }

        {
          directory = "Recordings";
          mode = "0700";
        }
      ];
    };
  };
}

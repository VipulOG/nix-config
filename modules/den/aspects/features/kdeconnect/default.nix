{
  den.aspects.kdeconnect = {user}: {
    nixos = {
      programs.kdeconnect.enable = true;

      networking.firewall = rec {
        allowedUDPPortRanges = allowedTCPPortRanges;

        allowedTCPPortRanges = [
          {
            from = 1714;
            to = 1764;
          }
        ];
      };
    };

    homeManager = {
      services.kdeconnect = {
        enable = true;
      };
    };

    preservation = {
      preserve.users.${user.name}.directories = [
        {
          directory = ".config/kdeconnect";
          mode = "0700";
        }
      ];
    };
  };
}

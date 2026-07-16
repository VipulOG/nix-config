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

    persist = {
      preserve.users.${user.name}.directories = [
        ".config/kdeconnect"
      ];
    };
  };
}

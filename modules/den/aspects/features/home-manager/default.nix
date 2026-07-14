{
  den.aspects.home-manager = {user}: {
    os = {pkgs, ...}: {
      home-manager = {
        useGlobalPkgs = true;
        useUserPackages = true;
        backupCommand = "${pkgs.trash-cli}/bin/trash-put";
      };
    };

    persist = {
      preserve.users.${user.name}.directories = [
        {
          directory = ".local/state/home-manager";
          mode = "0700";
        }
      ];
    };
  };
}

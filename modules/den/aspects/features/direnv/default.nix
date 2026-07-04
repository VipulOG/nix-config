{
  den.aspects.direnv = {
    homeManager = {
      programs.direnv = {
        enable = true;
        nix-direnv.enable = true;
      };
    };

    preservation = {user}: {
      preserve.users.${user.name}.directories = [
        {
          directory = ".local/share/direnv";
          mode = "0700";
        }
      ];
    };
  };
}

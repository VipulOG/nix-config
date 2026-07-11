{
  den.aspects.direnv = {user}: {
    homeManager = {
      programs.direnv = {
        enable = true;
        nix-direnv.enable = true;
      };
    };

    preservation = {
      preserve.users.${user.name}.directories = [
        {
          directory = ".local/share/direnv";
          mode = "0700";
        }
      ];
    };
  };
}

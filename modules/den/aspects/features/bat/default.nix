{
  den.aspects.bat = {
    homeManager = {
      programs.bat = {
        enable = true;
      };
    };

    preservation = {user}: {
      preserve.users.${user.name}.directories = [
        {
          directory = ".cache/bat";
          mode = "0700";
        }
      ];
    };
  };
}

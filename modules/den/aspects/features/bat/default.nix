{
  den.aspects.bat = {user}: {
    homeManager = {
      programs.bat = {
        enable = true;
      };
    };

    preservation = {
      preserve.users.${user.name}.directories = [
        {
          directory = ".cache/bat";
          mode = "0700";
        }
      ];
    };
  };
}

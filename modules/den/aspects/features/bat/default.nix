{
  den.aspects.bat = {user}: {
    homeManager = {
      programs.bat = {
        enable = true;
      };
    };

    persist = {
      preserve.users.${user.name}.directories = [
        {
          directory = ".cache/bat";
          mode = "0700";
        }
      ];
    };
  };
}

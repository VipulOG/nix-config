{
  den.aspects.qutebrowser = {
    homeManager = {
      programs.qutebrowser = {
        enable = true;
      };
    };

    preservation = {user}: {
      preserve.users.${user.name}.directories = [
        {
          directory = ".local/share/qutebrowser";
          mode = "0700";
        }
      ];
    };
  };
}

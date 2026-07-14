{
  den.aspects.qutebrowser = {user}: {
    homeManager = {
      programs.qutebrowser = {
        enable = true;
      };
    };

    persist = {
      preserve.users.${user.name}.directories = [
        {
          directory = ".local/share/qutebrowser";
          mode = "0700";
        }

        {
          directory = ".cache/qutebrowser";
          mode = "0700";
        }
      ];
    };
  };
}

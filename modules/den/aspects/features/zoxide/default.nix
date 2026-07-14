{
  den.aspects.zoxide = {user}: {
    homeManager = {
      programs.zoxide = {
        enable = true;
        options = ["--cmd" "cd"];
      };
    };

    persist = {
      preserve.users.${user.name}.directories = [
        {
          directory = ".local/share/zoxide";
          mode = "0700";
        }
      ];
    };
  };
}

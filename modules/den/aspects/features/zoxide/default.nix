{
  den.aspects.zoxide = {
    homeManager = {
      programs.zoxide = {
        enable = true;
        options = ["--cmd" "cd"];
      };
    };

    preservation = {user}: {
      preserve.users.${user.name}.directories = [
        {
          directory = ".local/share/zoxide";
          mode = "0700";
        }
      ];
    };
  };
}

{
  inputs,
  self,
  ...
}: {
  den.aspects.neovim = {
    homeManager = {
      imports = [inputs.nvf.homeManagerModules.default];

      programs.nvf = {
        enable = true;

        settings = {
          imports = [self.neovimModules.default];
        };
      };
    };

    preservation = {user}: {
      preserve.users.${user.name}.directories = [
        {
          directory = ".local/share/nvf";
          mode = "0700";
        }

        {
          directory = ".local/state/nvf";
          mode = "0700";
        }
      ];
    };
  };
}

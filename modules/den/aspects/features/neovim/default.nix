{
  inputs,
  self,
  ...
}: {
  den.aspects.neovim = {
    nixos = {
      environment.variables = {
        EDITOR = "nvim";
      };
    };

    homeManager = {
      imports = [inputs.nvf.homeManagerModules.default];

      programs.nvf = {
        enable = true;

        settings = {
          imports = [self.nvfModules.default];
        };
      };

      systemd.user.sessionVariables = {
        EDITOR = "nvim";
        VISUAL = "nvim";
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

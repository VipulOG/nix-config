{inputs, ...}: {
  flake-file.inputs = {
    nix-index = {
      url = "github:nix-community/nix-index-database";
      inputs.nixpkgs.follows = "nixpkgs";
    };
  };

  den.aspects.nix-index = {user}: {
    homeManager = {
      imports = [inputs.nix-index.homeModules.nix-index];

      programs = {
        nix-index.enable = true;
        nix-index-database.comma.enable = true;
      };
    };

    preservation = {
      preserve.users.${user.name}.directories = [
        {
          directory = ".cache/nix-index";
          mode = "0700";
        }
      ];
    };
  };
}

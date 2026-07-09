{
  inputs,
  self,
  ...
}: {
  flake-file.inputs = {
    nvf = {
      url = "github:notashelf/nvf";
      inputs.nixpkgs.follows = "nixpkgs";
      inputs.flake-parts.follows = "flake-parts";
    };
  };

  flake.nvfModules = {
    default = import ./_modules/default.nix;
    min = import ./_modules/min.nix;
    max = import ./_modules/max.nix;
  };

  perSystem = {
    pkgs,
    self',
    ...
  }: {
    packages = let
      mkNvfCfg = modName: (inputs.nvf.lib.neovimConfiguration {
        inherit pkgs;
        modules = [self.nvfModules.${modName}];
      });

      mkNeovim = modName: (mkNvfCfg modName).neovim;
    in {
      neovim-default = mkNeovim "default";
      neovim-min = mkNeovim "min";
      neovim-max = mkNeovim "max";

      neovim = self'.packages.neovim-default;
    };
  };
}

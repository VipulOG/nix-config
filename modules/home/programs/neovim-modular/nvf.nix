{
  inputs,
  lib,
  config,
  self,
  ...
}: let
  cfg = config.custom.programs.neovim;
in {
  options.custom.programs.neovim = {
    enable = self.lib.mkCustomEnableOption "neovim";
  };

  imports = [
    inputs.nvf.homeManagerModules.default
    ./config
  ];

  config = lib.mkIf cfg.enable {
    home.sessionVariables = {
      VISUAL = "nvim";
      EDITOR = "nvim";
    };

    programs.nvf = {
      enable = true;
    };
  };
}

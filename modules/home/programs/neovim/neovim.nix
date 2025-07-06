{
  config,
  lib,
  self,
  self',
  ...
}: let
  cfg = config.custom.programs.neovim;
in {
  options.custom.programs.neovim = {
    enable = self.lib.mkCustomEnableOption "neovim";
    package = lib.mkPackageOption self'.packages "neovim" {};
  };

  config = lib.mkIf cfg.enable {
    home = {
      packages = [
        cfg.package
      ];
      sessionVariables = {
        EDITOR = "nvim";
        VISUAL = "nvim";
      };
    };
  };
}

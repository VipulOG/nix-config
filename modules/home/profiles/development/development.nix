{
  config,
  lib,
  self,
  ...
}: let
  cfg = config.custom.profiles.development;
in {
  options.custom.profiles.development = {
    enable = self.lib.mkCustomEnableOption "development profile";
  };

  config = lib.mkIf cfg.enable {
    custom = {
      programs = {
        git.enable = true;
        lazygit.enable = true;
        neovim.enable = true;
        atuin.enable = true;
        starship.enable = true;
        zoxide.enable = true;
        direnv.enable = true;
        zellij.enable = true;
      };
    };
  };
}

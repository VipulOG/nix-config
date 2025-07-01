{
  config,
  lib,
  self,
  ...
}: let
  cfg = config.custom.profiles.common;
in {
  options.custom.profiles.common = {
    enable = self.lib.mkCustomEnableOption "common profile";
  };

  config = lib.mkIf cfg.enable {
    custom = {
      programs = {
        home-manager.enable = true;
        zsh.enable = true;
        git.enable = true;
        btop.enable = true;
        nnn.enable = true;
        coreutils.enable = true;
      };
    };
  };
}

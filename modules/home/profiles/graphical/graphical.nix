{
  config,
  lib,
  self,
  ...
}: let
  cfg = config.custom.profiles.graphical;
in {
  options.custom.profiles.graphical = {
    enable = self.lib.mkCustomEnableOption "graphical profile";
  };

  config = lib.mkIf cfg.enable {
    custom = {
      programs = {
        ghostty.enable = true;
        zen-browser.enable = true;
      };

      services = {
        redirector.enable = true;
      };
    };
  };
}

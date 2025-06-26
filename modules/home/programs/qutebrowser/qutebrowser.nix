{
  config,
  lib,
  pkgs,
  self,
  ...
}: let
  cfg = config.custom.programs.qutebrowser;
in {
  options.custom.programs.qutebrowser = {
    enable = self.lib.mkCustomEnableOption "qutebrowser";
    package = lib.mkPackageOption pkgs "qutebrowser" {};
  };

  config = lib.mkIf cfg.enable {
    programs.qutebrowser = {
      enable = true;
      settings = {
        tabs.tabs_are_windows = true;
        colors.webpage.preferred_color_scheme = "dark";
      };
    };
  };
}

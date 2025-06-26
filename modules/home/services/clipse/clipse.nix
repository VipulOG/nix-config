{
  config,
  lib,
  pkgs,
  self,
  ...
}: let
  cfg = config.custom.services.clipse;
in {
  options.custom.services.clipse = {
    enable = self.lib.mkCustomEnableOption "clipse";
    package = lib.mkPackageOption pkgs "clipse" {};
  };

  config = lib.mkIf cfg.enable {
    services.clipse = {
      enable = true;
      historySize = 100;
      allowDuplicates = false;
      imageDisplay = {
        type = "kitty";
        scaleX = 24;
        scaleY = 24;
        heightCut = 8;
      };
    };
  };
}

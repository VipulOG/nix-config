{
  config,
  lib,
  pkgs,
  self,
  ...
}: let
  cfg = config.custom.programs.swaylock;
in {
  options.custom.programs.swaylock = {
    enable = self.lib.mkCustomEnableOption "swaylock";
    package = lib.mkPackageOption pkgs "swaylock-effects" {};
  };

  config = lib.mkIf cfg.enable {
    programs.swaylock = {
      enable = true;
      inherit (cfg) package;

      settings = {
        clock = true;
        datestr = "";
        timestr = "%H:%M";
        indicator-idle-visible = true;
        indicator-radius = 100;
        effect-blur = "7x3";
        effect-scale = 2;
        effect-vignette = "0.5:0.5";
      };
    };
  };
}

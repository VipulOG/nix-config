{
  config,
  lib,
  pkgs,
  ...
}:
with lib; let
  cfg = config.internal.programs.swaylock;
in {
  options.internal.programs.swaylock = {
    enable = mkEnableOption "swaylock";

    package = mkOption {
      type = types.package;
      default = pkgs.swaylock-effects;
      description = "The package to use for swaylock.";
    };
  };

  config = mkIf cfg.enable {
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

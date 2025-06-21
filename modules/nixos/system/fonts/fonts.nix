{
  config,
  self,
  lib,
  ...
}: let
  cfg = config.custom.system.fonts;
in {
  options.custom.system.fonts = {
    enable = self.lib.mkCustomEnableOption "fonts";
  };

  config = lib.mkIf cfg.enable {
    fonts = {
      fontconfig = {
        enable = true;
        antialias = true;

        hinting = {
          enable = true;
          autohint = false;
          style = "full";
        };

        subpixel = {
          lcdfilter = "default";
          rgba = "rgb";
        };
      };

      fontDir = {
        enable = true;
        decompressFonts = true;
      };
    };
  };
}

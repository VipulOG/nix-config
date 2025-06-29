{
  config,
  pkgs,
  lib,
  self,
  ...
}: let
  cfg = config.custom.de.niri;
in {
  options.custom.de.niri = {
    enable = self.lib.mkCustomEnableOption "niri de";
  };

  config = lib.mkIf cfg.enable {
    custom = {
      programs = {
        niri.enable = true;
        wofi.enable = true;
        swaylock.enable = true;
        nautilus.enable = true;
        eog.enable = true;
      };

      services = {
        mako.enable = true;
        swayosd.enable = true;
        wpaperd.enable = true;
        swayidle = {
          enable = true;
          monitorsOffCommand = "${lib.getExe pkgs.niri} msg action power-off-monitors";
          monitorsOnCommand = "${lib.getExe pkgs.niri} msg action power-on-monitors";
        };
        clipse.enable = true;
      };

      misc.stylix = {
        enable = true;
        extraConfig.image = ./wallpaper.jpg;
      };
    };
  };
}

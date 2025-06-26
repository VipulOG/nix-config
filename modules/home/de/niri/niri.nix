{
  config,
  pkgs,
  lib,
  ...
}:
with lib; let
  cfg = config.internal.de.niri;
in {
  options.internal.de.niri = {
    enable = mkEnableOption "niri de";
  };

  config = mkIf cfg.enable {
    internal = {
      programs = {
        niri.enable = true;
        wofi.enable = true;
        swaylock.enable = true;
        xwayland-satellite.enable = true;
        wl-clipboard.enable = true;
        nautilus.enable = true;
      };

      services = {
        mako.enable = true;
        swayosd.enable = true;
        swayidle = {
          enable = true;
          monitorsOffCommand = "${lib.getExe pkgs.niri} msg action power-off-monitors";
          monitorsOnCommand = "${lib.getExe pkgs.niri} msg action power-on-monitors";
        };
      };

      misc.stylix = {
        enable = true;
        extraConfig.image = ./wallpaper.jpg;
      };
    };
  };
}

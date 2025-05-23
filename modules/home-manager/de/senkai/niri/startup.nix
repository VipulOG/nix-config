{
  lib,
  config,
  pkgs,
  self,
  ...
}:
with lib; let
  senkaiCfg = config.internal.de.senkai;
in {
  config = mkIf senkaiCfg.enable {
    programs.niri.settings.spawn-at-startup = [
      {command = ["${getExe pkgs.xwayland-satellite}"];}
      {command = ["${getExe' pkgs.swayosd "swayosd-server"}"];}
      {command = ["${getExe pkgs.clipse}" "-listen"];}
      {command = ["${getExe pkgs.swaybg}" "-i" "${self.lib.relativeToRoot "assets/wallpapers/wallpaper.jpg"}"];}
      {command = ["${getExe pkgs.waybar}"];}
      # https://github.com/sodiboo/niri-flake/issues/509
      {command = ["systemctl" "--user" "restart" "xdg-desktop-portal-gnome"];}
    ];
  };
}

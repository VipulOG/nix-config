{
  config,
  lib,
  pkgs,
  self,
  ...
}: let
  cfg = config.custom.programs.xwayland-satellite;
in {
  options.custom.programs.xwayland-satellite = {
    enable = self.lib.mkCustomEnableOption "xwayland-satellite";
    package = lib.mkPackageOption pkgs "xwayland-satellite" {};
  };
  config = lib.mkIf cfg.enable {
    home.packages = [
      cfg.package
    ];
  };
}

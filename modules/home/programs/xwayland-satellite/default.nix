{
  config,
  lib,
  pkgs,
  ...
}:
with lib; let
  cfg = config.internal.programs.xwayland-satellite;
in {
  options.internal.programs.xwayland-satellite = {
    enable = mkEnableOption "xwayland-satellite";
    package = mkPackageOption pkgs "xwayland-satellite" {};
  };
  config = mkIf cfg.enable {
    home.packages = [
      cfg.package
    ];
  };
}

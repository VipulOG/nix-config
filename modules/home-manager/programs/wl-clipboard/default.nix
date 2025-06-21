{
  config,
  lib,
  pkgs,
  ...
}:
with lib; let
  cfg = config.internal.programs.wl-clipboard;
in {
  options.internal.programs.wl-clipboard = {
    enable = mkEnableOption "wl-clipboard";
    package = mkPackageOption pkgs "wl-clipboard" {};
  };
  config = mkIf cfg.enable {
    home.packages = [
      cfg.package
    ];
  };
}

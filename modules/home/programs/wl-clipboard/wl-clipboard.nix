{
  config,
  lib,
  pkgs,
  self,
  ...
}: let
  cfg = config.custom.programs.wl-clipboard;
in {
  options.custom.programs.wl-clipboard = {
    enable = self.lib.mkCustomEnableOption "wl-clipboard";
    package = lib.mkPackageOption pkgs "wl-clipboard" {};
  };
  config = lib.mkIf cfg.enable {
    home.packages = [
      cfg.package
    ];
  };
}

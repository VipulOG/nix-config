{
  config,
  lib,
  pkgs,
  self,
  ...
}: let
  cfg = config.custom.programs.nautilus;
in {
  options.custom.programs.nautilus = {
    enable = self.lib.mkCustomEnableOption "nautilus";
    package = lib.mkPackageOption pkgs "nautilus" {};
  };
  config = lib.mkIf cfg.enable {
    home.packages = [
      cfg.package
    ];
  };
}

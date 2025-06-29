{
  config,
  lib,
  pkgs,
  self,
  ...
}: let
  cfg = config.custom.programs.eog;
in {
  options.custom.programs.eog = {
    enable = self.lib.mkCustomEnableOption "eog";
    package = lib.mkPackageOption pkgs "eog" {};
  };
  config = lib.mkIf cfg.enable {
    home.packages = [
      cfg.package
    ];
  };
}

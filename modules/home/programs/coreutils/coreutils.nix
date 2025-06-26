{
  config,
  lib,
  pkgs,
  self,
  ...
}: let
  cfg = config.custom.programs.coreutils;
in {
  options.custom.programs.coreutils = {
    enable = self.lib.mkCustomEnableOption "coreutils";
    package = lib.mkPackageOption pkgs "coreutils" {};
  };

  config = lib.mkIf cfg.enable {
    home.packages = [
      cfg.package
    ];
  };
}

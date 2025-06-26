{
  config,
  lib,
  pkgs,
  self,
  ...
}: let
  cfg = config.custom.programs.nnn;
in {
  options.custom.programs.nnn = {
    enable = self.lib.mkCustomEnableOption "nnn";
    package = lib.mkPackageOption pkgs "nnn" {};
  };

  config = lib.mkIf cfg.enable {
    programs.nnn = {
      enable = true;
    };
  };
}

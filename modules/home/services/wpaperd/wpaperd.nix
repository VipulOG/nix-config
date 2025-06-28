{
  lib,
  pkgs,
  config,
  self,
  ...
}: let
  cfg = config.custom.services.wpaperd;
in {
  options.custom.services.wpaperd = {
    enable = self.lib.mkCustomEnableOption "wpaperd";
    package = lib.mkPackageOption pkgs "wpaperd" {};
  };

  config = lib.mkIf cfg.enable {
    services.wpaperd = {
      enable = true;
      inherit (cfg) package;
    };
  };
}

{
  config,
  lib,
  pkgs,
  self,
  ...
}: let
  cfg = config.custom.programs.atuin;
in {
  options.custom.programs.atuin = {
    enable = self.lib.mkCustomEnableOption "atuin";
    package = lib.mkPackageOption pkgs "atuin" {};
  };

  config = lib.mkIf cfg.enable {
    programs.atuin = {
      enable = true;
      inherit (cfg) package;
      daemon.enable = true;
    };
  };
}

{
  config,
  lib,
  pkgs,
  self,
  ...
}: let
  cfg = config.custom.programs.zoxide;
in {
  options.custom.programs.zoxide = {
    enable = self.lib.mkCustomEnableOption "zoxide";
    package = lib.mkPackageOption pkgs "zoxide" {};
  };

  config = lib.mkIf cfg.enable {
    programs.zoxide = {
      enable = true;
      inherit (cfg) package;
    };
  };
}

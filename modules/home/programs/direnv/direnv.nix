{
  config,
  lib,
  pkgs,
  self,
  ...
}: let
  cfg = config.custom.programs.direnv;
in {
  options.custom.programs.direnv = {
    enable = self.lib.mkCustomEnableOption "direnv";
    package = lib.mkPackageOption pkgs "direnv" {};
  };

  config = lib.mkIf cfg.enable {
    programs.direnv = {
      enable = true;
      inherit (cfg) package;
      nix-direnv.enable = true;
    };
  };
}

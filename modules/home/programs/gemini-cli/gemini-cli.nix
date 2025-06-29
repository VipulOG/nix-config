{
  config,
  lib,
  pkgs,
  self,
  ...
}: let
  cfg = config.custom.programs.gemini-cli;
in {
  options.custom.programs.gemini-cli = {
    enable = self.lib.mkCustomEnableOption "gemini-cli";
    package = lib.mkPackageOption pkgs "gemini-cli" {};
  };
  config = lib.mkIf cfg.enable {
    home.packages = [
      cfg.package
    ];
  };
}

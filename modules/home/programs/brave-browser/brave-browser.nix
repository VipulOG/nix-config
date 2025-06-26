{
  config,
  lib,
  pkgs,
  self,
  ...
}: let
  cfg = config.custom.programs.brave-browser;
in {
  options.custom.programs.brave-browser = {
    enable = self.lib.mkCustomEnableOption "brave-browser";
    package = lib.mkPackageOption pkgs "brave-browser" {};
  };

  config = lib.mkIf cfg.enable {
    programs.brave = {
      enable = true;
      commandLineArgs = [
        "--no-default-browser-check"
        "--restore-last-session"
      ];
    };
  };
}

{
  inputs',
  config,
  lib,
  self,
  ...
}: let
  cfg = config.custom.programs.zen-browser;
in {
  options.custom.programs.zen-browser = {
    enable = self.lib.mkCustomEnableOption "zen-browser";
    package = lib.mkPackageOption inputs'.zen-browser.packages "default" {};
  };

  config = lib.mkIf cfg.enable {
    home.packages = [
      cfg.package
    ];
  };
}

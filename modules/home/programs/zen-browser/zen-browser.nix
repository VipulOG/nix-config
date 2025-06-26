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

    package = lib.mkOption {
      type = lib.types.package;
      inherit (inputs'.zen-browser.packages) default;
      description = "The package to use for zen-browser.";
    };
  };

  config = lib.mkIf cfg.enable {
    home.packages = [
      cfg.package
    ];
  };
}

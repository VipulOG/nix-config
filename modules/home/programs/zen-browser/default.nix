{
  inputs',
  config,
  lib,
  ...
}:
with lib; let
  cfg = config.internal.programs.zen-browser;
in {
  options.internal.programs.zen-browser = {
    enable = mkEnableOption "zen-browser";

    package = mkOption {
      type = types.package;
      inherit (inputs'.zen-browser.packages) default;
      description = "The package to use for zen-browser.";
    };
  };

  config = mkIf cfg.enable {
    home.packages = [
      cfg.package
    ];
  };
}

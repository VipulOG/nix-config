{
  config,
  lib,
  pkgs,
  self,
  ...
}: let
  cfg = config.custom.programs.android-studio;
in {
  options.custom.programs.android-studio = {
    enable = self.lib.mkCustomEnableOption "android-studio";
    package = lib.mkPackageOption pkgs.androidStudioPackages "dev" {};
  };

  config = lib.mkIf cfg.enable {
    home.packages = [
      cfg.package
    ];
  };
}

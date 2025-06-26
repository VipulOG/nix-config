{
  config,
  lib,
  self,
  self',
  ...
}: let
  cfg = config.custom.programs.whatsapp-web;
in {
  options.custom.programs.whatsapp-web = {
    enable = self.lib.mkCustomEnableOption "whatsapp-web";
    package = lib.mkPackageOption self'.packages "whatsapp-web" {};
  };
  config = lib.mkIf cfg.enable {
    home.packages = [
      cfg.package
    ];
  };
}

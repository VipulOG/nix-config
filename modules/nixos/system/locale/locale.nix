{
  config,
  self,
  lib,
  ...
}: let
  cfg = config.custom.system.locale;
in {
  options.custom.system.locale = {
    enable = self.lib.mkCustomEnableOption "locale";
  };

  config = lib.mkIf cfg.enable {
    i18n.defaultLocale = "en_US.UTF-8";
    console = {
      keyMap = lib.mkForce "us";
    };
  };
}

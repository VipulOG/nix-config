{
  config,
  self,
  lib,
  ...
}: let
  cfg = config.custom.system.boot;
in {
  options.custom.system.boot = {
    enable = self.lib.mkCustomEnableOption "boot";
  };

  config = lib.mkIf cfg.enable {
    boot.loader = {
      systemd-boot = {
        enable = true;
        configurationLimit = 20;
        editor = false;
      };
      efi.canTouchEfiVariables = true;
      timeout = 3;
    };
  };
}

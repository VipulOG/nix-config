{
  config,
  self,
  lib,
  ...
}: let
  cfg = config.custom.services.dm;
in {
  options.custom.services.dm = {
    enable = self.lib.mkCustomEnableOption "dm";
  };

  config = lib.mkIf cfg.enable {
    services.displayManager = {
      enable = true;
      ly.enable = true;
    };
  };
}

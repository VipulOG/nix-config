{
  config,
  self,
  lib,
  ...
}: let
  cfg = config.custom.system.time;
in {
  options.custom.system.time = {
    enable = self.lib.mkCustomEnableOption "time";
  };

  config = lib.mkIf cfg.enable {
    time = {
      inherit (config.custom.vars) timeZone;
    };
  };
}

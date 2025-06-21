{
  config,
  self,
  lib,
  ...
}: let
  cfg = config.custom.de.niri;
in {
  options.custom.de.niri = {
    enable = self.lib.mkCustomEnableOption "niri de";
  };

  config = lib.mkIf cfg.enable {
    programs.niri.enable = true;
  };
}

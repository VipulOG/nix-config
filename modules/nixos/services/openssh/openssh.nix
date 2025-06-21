{
  config,
  self,
  lib,
  ...
}: let
  cfg = config.custom.services.openssh;
in {
  options.custom.services.openssh = {
    enable = self.lib.mkCustomEnableOption "openssh";
  };

  config = lib.mkIf cfg.enable {
    services.openssh = {
      enable = true;
    };
  };
}

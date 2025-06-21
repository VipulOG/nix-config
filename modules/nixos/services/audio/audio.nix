{
  config,
  self,
  lib,
  pkgs,
  ...
}: let
  cfg = config.custom.services.audio;
in {
  options.custom.services.audio = {
    enable = self.lib.mkCustomEnableOption "audio";
  };

  config = lib.mkIf cfg.enable {
    services.pipewire.enable = true;
    security.rtkit.enable = true;
    environment.systemPackages = [pkgs.playerctl];
  };
}

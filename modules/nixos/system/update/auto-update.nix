{
  config,
  self,
  lib,
  host,
  ...
}: let
  input = "github:vipulog/nix-config?ref=main";
  cfg = config.custom.system.autoUpdate;
in {
  options.custom.system.autoUpdate = {
    enable = self.lib.mkCustomEnableOption "auto updates";
  };

  config = lib.mkIf cfg.enable {
    system.autoUpgrade = {
      enable = true;
      flake = "${input}#${host}";
      dates = "weekly";
      randomizedDelaySec = "45min";
      operation = "boot";
      flags = [
        "-L" # print build logs
      ];
    };
  };
}

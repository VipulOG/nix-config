{
  config,
  lib,
  self,
  ...
}: let
  cfg = config.custom.services.home-manager;
in {
  options.custom.services.home-manager = {
    enable = self.lib.mkCustomEnableOption "home-manager";

    extraConfig = lib.mkOption {
      type = lib.types.attrsOf lib.types.anything;
      description = "Additional home-manager services configuration options.";
      default = {};
    };
  };

  config = lib.mkIf cfg.enable {
    services.home-manager = lib.mkMerge [
      (lib.mkDefault {
        autoExpire = {
          enable = true;
          frequency = "monthly";
          timestamp = "-30 days";
          store = {
            cleanup = true;
            options = "--delete-older-than 30d";
          };
        };
        autoUpgrade = {
          enable = true;
          frequency = "weekly";
        };
      })

      cfg.extraConfig
    ];
  };
}

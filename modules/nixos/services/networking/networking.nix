{
  config,
  self,
  lib,
  host,
  ...
}: let
  cfg = config.custom.services.networking;
in {
  options.custom.services.networking = {
    enable = self.lib.mkCustomEnableOption "networking";

    users = lib.mkOption {
      type = lib.types.listOf lib.types.str;
      default = [];
      description = "List of users to add to the networking group";
    };

    group = lib.mkOption {
      type = lib.types.str;
      default = "networkmanager";
      description = "Group to add users to for networking access";
    };
  };

  config = lib.mkIf cfg.enable {
    networking = {
      networkmanager.enable = true;
      hostName = host;
    };

    users.users = lib.genAttrs cfg.users (_name: {
      extraGroups = lib.mkBefore [cfg.group];
    });
  };
}

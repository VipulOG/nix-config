{
  config,
  lib,
  self,
  ...
}: let
  cfg = config.custom.users.vipul;
in {
  options.custom.users.vipul = {
    enable = self.lib.mkCustomEnableOption "user \"vipul\"";
  };

  config = lib.mkIf cfg.enable {
    home = {
      username = "vipul";
      homeDirectory = "/home/vipul";
    };

    custom = {
      profiles = {
        common.enable = true;
      };
    };
  };
}

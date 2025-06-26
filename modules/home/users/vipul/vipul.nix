{
  config,
  lib,
  ...
}: let
  cfg = config.internal.users.vipul;
in {
  options.internal.users.vipul = {
    enable = lib.mkEnableOption "user \"vipul\"";
  };

  config = lib.mkIf cfg.enable {
    home = {
      username = "vipul";
      homeDirectory = "/home/vipul";
    };

    internal = {
      profiles = {
        common.enable = true;
      };
    };
  };
}

{
  config,
  self,
  pkgs,
  lib,
  ...
}: let
  cfg = config.custom.users.vipul;
in {
  options.custom.users.vipul = {
    enable = self.lib.mkCustomEnableOption "user \"vipul\"";

    isAdmin = lib.mkOption {
      type = lib.types.bool;
      default = true;
      description = "Whether to add this user to the wheel group.";
    };
  };

  config = lib.mkIf cfg.enable {
    users.users.vipul = {
      isNormalUser = true;
      initialPassword = "1";
      shell = pkgs.zsh;
      extraGroups = lib.optionals cfg.isAdmin ["wheel"];
    };
  };
}

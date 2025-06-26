{
  config,
  lib,
  self,
  pkgs,
  ...
}: let
  cfg = config.custom.services.mako;

  colors =
    if config.custom.misc.stylix.enable
    then config.lib.stylix.colors.withHashtag
    else config.custom.common.constants.colorScheme.withHashtag;
in {
  options.custom.services.mako = {
    enable = self.lib.mkCustomEnableOption "mako";
    package = lib.mkPackageOption pkgs "mako" {};
  };
  config = lib.mkIf cfg.enable {
    services.mako = {
      enable = true;
      inherit (cfg) package;
      settings = {
        font = lib.mkForce "monospace 12";
        margin = "4";
        outer-margin = "0";
        padding = "8";
        width = "320";
        border-color = lib.mkForce colors.base03;
        border-size = 3;
      };
    };
  };
}

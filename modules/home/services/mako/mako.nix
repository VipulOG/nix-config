{
  config,
  lib,
  ...
}:
with lib; let
  cfg = config.internal.services.mako;

  colors =
    if builtins.hasAttr "withHashtag" config.lib.stylix.colors
    then config.lib.stylix.colors.withHashtag
    else config.custom.common.constants.colorScheme.withHashtag;
in {
  options.internal.services.mako = {
    enable = mkEnableOption "mako";
  };
  config = mkIf cfg.enable {
    services.mako = {
      enable = true;
      settings = {
        font = mkForce "monospace 12";
        margin = "4";
        outer-margin = "0";
        padding = "8";
        width = "320";
        border-color = mkForce colors.base03;
        border-size = 3;
      };
    };
  };
}

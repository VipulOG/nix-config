{
  config,
  lib,
  ...
}:
with lib; let
  cfg = config.internal.services.mako;

  colors =
    if builtins.hasAttr "withHashtags" config.lib.stylix.colors
    then config.lib.stylix.colors.withHashtags
    else config.custom.common.constants.colorscheme;
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

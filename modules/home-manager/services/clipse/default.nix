{
  config,
  lib,
  ...
}:
with lib; let
  cfg = config.internal.services.clipse;
in {
  options.internal.services.clipse = {
    enable = mkEnableOption "clipse";
    package = lib.mkPackageOption pkgs "clipse" {};
  };

  config = mkIf cfg.enable {
    services.clipse = {
      enable = true;
      historySize = 100;
      allowDuplicates = false;
      imageDisplay = {
        type = "kitty";
        scaleX = 24;
        scaleY = 24;
        heightCut = 8;
      };
    };
  };
}

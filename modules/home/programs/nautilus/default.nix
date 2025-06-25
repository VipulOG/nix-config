{
  config,
  lib,
  pkgs,
  ...
}:
with lib; let
  cfg = config.internal.programs.nautilus;
in {
  options.internal.programs.nautilus = {
    enable = mkEnableOption "nautilus";
  };
  config = mkIf cfg.enable {
    home.packages = with pkgs; [
      nautilus
    ];
  };
}

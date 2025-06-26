{
  lib,
  config,
  inputs,
  ...
} @ args:
with lib; let
  cfg = config.internal.programs.niri;
in {
  imports = [inputs.niri.homeModules.niri];

  options.internal.programs.niri = {
    enable = mkEnableOption "niri";
  };

  config = mkIf cfg.enable {
    nixpkgs.overlays = [inputs.niri.overlays.niri];
    programs.niri.config = import ./config/config.nix args;
  };
}

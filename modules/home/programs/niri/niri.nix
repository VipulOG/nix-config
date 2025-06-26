{
  lib,
  config,
  inputs,
  self,
  pkgs,
  ...
} @ args: let
  cfg = config.custom.programs.niri;
in {
  imports = [inputs.niri.homeModules.niri];

  options.custom.programs.niri = {
    enable = self.lib.mkCustomEnableOption "niri";
    package = lib.mkPackageOption pkgs "niri-unstable" {};
  };

  config = lib.mkIf cfg.enable {
    nixpkgs.overlays = [inputs.niri.overlays.niri];
    programs.niri.config = import ./config args;
  };
}

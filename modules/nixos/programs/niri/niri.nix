{
  config,
  self,
  lib,
  pkgs,
  inputs,
  ...
}: let
  cfg = config.custom.programs.niri;
in {
  options.custom.programs.niri = {
    enable = self.lib.mkCustomEnableOption "niri";
  };

  config = lib.mkIf cfg.enable {
    nixpkgs.overlays = [inputs.niri.overlays.niri];

    programs.niri = {
      enable = true;
      package = pkgs.niri-unstable;
    };
  };
}

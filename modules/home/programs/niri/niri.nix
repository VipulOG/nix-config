{
  lib,
  config,
  inputs,
  inputs',
  self,
  ...
} @ args: let
  cfg = config.custom.programs.niri;
in {
  imports = [inputs.niri.homeModules.niri];

  options.custom.programs.niri = {
    enable = self.lib.mkCustomEnableOption "niri";
    package = lib.mkPackageOption inputs'.niri.packages "niri-unstable" {};
  };

  config = lib.mkIf cfg.enable {
    nixpkgs.overlays = [inputs.niri.overlays.niri];
    programs.niri = {
      enable = true;
      inherit (cfg) package;
      config = import ./config args;
    };
  };
}

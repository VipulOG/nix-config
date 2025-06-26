{
  config,
  lib,
  pkgs,
  self,
  ...
}: let
  cfg = config.custom.programs.starship;
in {
  options.custom.programs.starship = {
    enable = self.lib.mkCustomEnableOption "starship";
    package = lib.mkPackageOption pkgs "starship" {};
  };

  config = lib.mkIf cfg.enable {
    programs.starship = {
      enable = true;
      settings = builtins.fromTOML (import ./config.nix);
    };
  };
}

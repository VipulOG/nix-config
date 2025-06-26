{
  lib,
  config,
  inputs',
  pkgs,
  self,
  ...
}: let
  cfg = config.custom.programs.zellij;
in {
  options.custom.programs.zellij = {
    enable = self.lib.mkCustomEnableOption "zellij";
    package = lib.mkPackageOption pkgs "zellij" {};
  };

  config = lib.mkIf cfg.enable {
    programs.zellij = {
      enable = true;
      inherit (cfg) package;
      settings = {
        show_startup_tips = false;
      };
    };

    xdg.configFile."zellij/layouts/default.kdl".text = import ./layouts/default.nix {
      inherit config inputs';
    };
  };
}

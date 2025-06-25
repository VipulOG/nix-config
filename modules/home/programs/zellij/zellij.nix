{
  lib,
  config,
  inputs',
  ...
}:
with lib; let
  cfg = config.internal.programs.zellij;
in {
  options.internal.programs.zellij = {
    enable = mkEnableOption "zellij";
  };

  config = mkIf cfg.enable {
    programs.zellij = {
      enable = true;
      settings = {
        show_startup_tips = false;
      };
    };

    xdg.configFile."zellij/layouts/default.kdl".text = import ./layouts/default.nix {
      inherit config inputs';
    };
  };
}

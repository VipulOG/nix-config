{
  pkgs,
  config,
  lib,
  self,
  ...
} @ args: let
  cfg = config.custom.programs.zsh;
in {
  options.custom.programs.zsh = {
    enable = self.lib.mkCustomEnableOption "zsh";
    package = lib.mkPackageOption pkgs "zsh" {};
  };

  config = lib.mkIf cfg.enable {
    programs.zsh = {
      enable = true;
      inherit (cfg) package;

      enableCompletion = true;
      autosuggestion.enable = true;
      syntaxHighlighting.enable = true;

      plugins = [
        {
          name = "vi-mode";
          src = pkgs.zsh-vi-mode;
          file = "share/zsh-vi-mode/zsh-vi-mode.plugin.zsh";
        }
      ];

      initContent = import ./init-scripts args;
    };
  };
}

{
  pkgs,
  config,
  lib,
  self,
  ...
}: let
  cfg = config.custom.programs.zsh;
in {
  options.custom.programs.zsh = {
    enable = self.lib.mkCustomEnableOption "zsh";
    package = lib.mkPackageOption pkgs "zsh";
  };

  config = lib.mkIf cfg.enable {
    programs.zsh = {
      enable = true;

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

      initContent = lib.concatStringsSep "\n" [
        (lib.readFile ./init-scripts/prompt.zsh)
      ];
    };
  };
}

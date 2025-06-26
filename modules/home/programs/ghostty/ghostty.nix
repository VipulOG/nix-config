{
  config,
  pkgs,
  lib,
  self,
  ...
}: let
  cfg = config.custom.programs.ghostty;
in {
  options.custom.programs.ghostty = {
    enable = self.lib.mkCustomEnableOption "ghostty";
    package = lib.mkPackageOption pkgs "ghostty" {};

    enableZellijIntegration = lib.mkOption {
      description = "Whether to enable zellij integration.";
      default = config.custom.programs.zellij.enable;
    };
  };

  config = lib.mkIf cfg.enable {
    programs.ghostty = {
      enable = true;
      inherit (cfg) package;

      settings =
        {
          window-padding-balance = true;
          window-padding-x = 3;
          window-padding-y = 3;
          window-padding-color = "background";
        }
        // lib.optionalAttrs cfg.enableZellijIntegration {
          command = "zellij";
          keybind = [
            "super+ctrl+shift+plus=unbind"
            "super+ctrl+shift+up=unbind"
            "super+ctrl+shift+down=unbind"
            "super+ctrl+shift+right=unbind"
            "super+ctrl+shift+left=unbind"
            "super+ctrl+left_bracket=unbind"
            "super+ctrl+right_bracket=unbind"
            "ctrl+alt+up=unbind"
            "ctrl+alt+down=unbind"
            "ctrl+alt+right=unbind"
            "ctrl+alt+left=unbind"
            "ctrl+shift+e=unbind"
            "ctrl+shift+o=unbind"
            "ctrl+shift+enter=unbind"
            "ctrl+shift+t=unbind"
            "ctrl+shift+w=unbind"
            "ctrl+shift+right=unbind"
            "ctrl+shift+left=unbind"
            "ctrl+shift+tab=unbind"
            "alt+one=unbind"
            "alt+two=unbind"
            "alt+three=unbind"
            "alt+four=unbind"
            "alt+five=unbind"
            "alt+six=unbind"
            "alt+seven=unbind"
            "alt+eight=unbind"
            "alt+nine=unbind"
            "ctrl+page_up=unbind"
            "ctrl+page_down=unbind"
            "ctrl+tab=unbind"
          ];
        };
    };
  };
}

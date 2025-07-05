{
  pkgs,
  inputs,
  lib,
  config,
  self,
  ...
}: let
  cfg = config.custom.misc.stylix;
in {
  imports = [inputs.stylix.homeModules.stylix];

  options.custom.misc.stylix = {
    enable = self.lib.mkCustomEnableOption "stylix";

    extraConfig = lib.mkOption {
      type = lib.types.attrsOf lib.types.anything;
      description = "Additional stylix configuration options.";
      default = {};
    };
  };

  config = lib.mkIf cfg.enable {
    stylix = lib.mkMerge [
      (lib.mkDefault {
        enable = true;
        image = config.lib.stylix.pixel "base03";
        base16Scheme = config.custom.common.vars.colorScheme.yaml;
        polarity = "dark";
        inherit (config.custom.common.vars) cursor;

        fonts = {
          emoji = {
            name = "Noto Color Emoji";
            package = pkgs.noto-fonts-emoji;
          };
          monospace = {
            name = "JetBrainsMono Nerd Font";
            package = pkgs.nerd-fonts.jetbrains-mono;
          };
          sansSerif = {
            name = "Inter";
            package = pkgs.inter;
          };
          serif = {
            name = "Merriweather";
            package = pkgs.merriweather;
          };
          sizes = {
            applications = 12;
            desktop = 12;
            popups = 12;
            terminal = 14;
          };
        };

        iconTheme = {
          enable = true;
          package = pkgs.colloid-icon-theme.override {
            schemeVariants = ["default"];
            colorVariants = ["default"];
          };
          light = "Colloid-Light";
          dark = "Colloid-Dark";
        };

        opacity = {
          applications = 1.0;
          desktop = 1.0;
          popups = 1.0;
          terminal = 1.0;
        };

        targets.nvf.enable = false;
      })

      (lib.removeAttrs cfg.extraConfig ["enable"])
    ];
  };
}

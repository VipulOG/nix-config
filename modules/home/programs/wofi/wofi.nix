{
  config,
  lib,
  pkgs,
  self,
  ...
}: let
  cfg = config.custom.programs.wofi;
in {
  options.custom.programs.wofi = {
    enable = self.lib.mkCustomEnableOption "wofi";
    package = lib.mkPackageOption pkgs "wofi";
  };

  config = lib.mkIf cfg.enable {
    programs.wofi = {
      enable = true;
      style = import ./style.nix {inherit config;};

      settings = {
        show = "drun";
        prompt = "Apps";

        width = "540px";
        height = "360px";
        location = 0;
        orientation = "vertical";
        line_wrap = false;
        dynamic_lines = false;

        allow_markup = true;
        allow_images = true;
        image_size = 24;

        exec_search = false;
        hide_search = false;
        parse_search = false;
        insensitive = true;

        hide_scroll = true;
        no_actions = true;
        sort_order = "default";
        gtk_dark = true;
        filter_rate = 100;

        key_exit = "Escape";
      };
    };
  };
}

{
  config,
  pkgs,
  lib,
  self,
  ...
}: let
  cfg = config.custom.programs.btop;
in {
  options.custom.programs.btop = {
    enable = self.lib.mkCustomEnableOption "btop";
    package = lib.mkPackageOption pkgs "btop" {};
  };

  config = lib.mkIf cfg.enable {
    programs.btop = {
      enable = true;
      inherit (cfg) package;

      settings = {
        vim_keys = true;
        theme_backgroud = false;
        rounded_corners = false;
        shown_boxes = "proc cpu gpu0 mem net";
        proc_tree = false;
        clock_format = "/user@/host %X - %A, %d %B %Y";
      };
    };
  };
}

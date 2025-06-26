{
  config,
  pkgs,
  lib,
  ...
}:
with lib; let
  cfg = config.internal.programs.btop;
in {
  options.internal.programs.btop = {
    enable = mkEnableOption "btop";
    package = mkPackageOption pkgs "btop" {};
  };

  config = mkIf cfg.enable {
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

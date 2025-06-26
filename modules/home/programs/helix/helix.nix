{
  config,
  lib,
  pkgs,
  self,
  ...
}: let
  cfg = config.custom.programs.helix;
in {
  options.custom.programs.helix = {
    enable = self.lib.mkCustomEnableOption "helix";
    package = lib.mkPackageOption pkgs "helix" {};
  };

  config = lib.mkIf cfg.enable {
    programs.helix = {
      enable = true;
      inherit (cfg) package;
      defaultEditor = true;
      settings = {
        editor.cursor-shape = {
          normal = "block";
          insert = "bar";
          select = "underline";
        };
      };
    };
  };
}

{
  config,
  lib,
  pkgs,
  self,
  ...
}: let
  cfg = config.custom.programs.lazygit;
in {
  options.custom.programs.lazygit = {
    enable = self.lib.mkCustomEnableOption "lazygit";
    package = lib.mkPackageOption pkgs "lazygit" {};
  };

  config = lib.mkIf cfg.enable {
    programs.lazygit = {
      enable = true;

      settings = {
        gui = {
          expandFocusedSidePanel = true;
          sidePanelWidth = 0.4;
          showRandomTip = false;
          showBottomLine = false;
          nerdFontsVersion = "3";
          showDivergenceFromBaseBranch = "arrowAndNumber";
          border = "single";
          statusPanelView = "allBranchesLog";
        };

        git = {
          paging = {
            pager = "${lib.getExe pkgs.delta} --dark --paging=never";
          };
        };
      };
    };
  };
}

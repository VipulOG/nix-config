{
  lib,
  config,
  ...
}: let
  cfg = config.custom.programs.neovim;
in {
  config = lib.mkIf cfg.enable {
    programs.nvf.settings.vim.git = {
      gitsigns = {
        enable = true;
        mappings = {
          nextHunk = "]h";
          previousHunk = "[h";
          blameLine = "<leader>gb";
          diffProject = "<leader>gD";
          diffThis = "<leader>gd";
          previewHunk = "<leader>gP";
          resetBuffer = "<leader>gR";
          resetHunk = "<leader>gr";
          stageBuffer = "<leader>gS";
          stageHunk = "<leader>gs";
          toggleBlame = "<leader>gtb";
          toggleDeleted = "<leader>gtd";
          undoStageHunk = "<leader>gu";
        };
      };
    };
  };
}

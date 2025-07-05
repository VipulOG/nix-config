{
  lib,
  config,
  ...
}: let
  cfg = config.custom.programs.neovim;
in {
  config = lib.mkIf cfg.enable {
    programs.nvf.settings.vim.visuals = {
      indent-blankline = {
        enable = true;
        setupOpts = {
          exclude.filetypes = ["log" "txt" "md" "dashboard" "help"];
        };
      };
      rainbow-delimiters.enable = true;
      nvim-web-devicons.enable = true;
      cinnamon-nvim = {
        enable = true;
        setupOpts = {
          keymaps.basic = true;
        };
      };
      cellular-automaton = {
        enable = true;
        mappings.makeItRain = null;
      };
    };
  };
}

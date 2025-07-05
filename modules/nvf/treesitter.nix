{
  lib,
  config,
  ...
}: let
  cfg = config.custom.programs.neovim;
in {
  config = lib.mkIf cfg.enable {
    programs.nvf.settings.vim.treesitter = {
      enable = true;
      autotagHtml = true;
      context = {
        enable = false;
        setupOpts = {
          line_numbers = false;
          max_lines = 4;
        };
      };
    };
  };
}

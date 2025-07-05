{
  lib,
  config,
  ...
}: let
  cfg = config.custom.programs.neovim;
in {
  config = lib.mkIf cfg.enable {
    programs.nvf.settings.vim.diagnostics = {
      enable = true;
      config = {
        virtual_lines = false;
        virtual_text = false;
        signs = true;
        underline = true;
        update_in_insert = false;
        float.border = "rounded";
      };
    };
    programs.nvf.settings.vim.keymaps = [
      {
        key = "<leader>e";
        mode = ["n"];
        action = "vim.diagnostic.open_float";
        lua = true;
        desc = "Show floating diagnostic";
      }
    ];
  };
}

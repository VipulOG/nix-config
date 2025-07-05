{
  lib,
  config,
  ...
}: let
  cfg = config.custom.programs.neovim;
in {
  config = lib.mkIf cfg.enable {
    programs.nvf.settings.vim.filetree.nvimTree = {
      enable = true;
      openOnSetup = false;
      mappings.toggle = "<leader>tt";
    };
  };
}

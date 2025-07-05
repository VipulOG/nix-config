{
  lib,
  config,
  ...
}: let
  cfg = config.custom.programs.neovim;
in {
  config = lib.mkIf cfg.enable {
    programs.nvf.settings.vim.options = {
      tabstop = 2;
      shiftwidth = 2;
      scrolloff = 4;
      wrap = false;
    };
  };
}

{
  lib,
  config,
  ...
}: let
  cfg = config.custom.programs.neovim;
in {
  config = lib.mkIf cfg.enable {
    programs.nvf.settings.vim.clipboard = {
      enable = true;
      registers = "unnamed";
      providers = {
        wl-copy.enable = true;
        xsel.enable = true;
      };
    };
  };
}

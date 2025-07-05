{
  lib,
  config,
  ...
}: let
  cfg = config.custom.programs.neovim;
in {
  config = lib.mkIf cfg.enable {
    programs.nvf.settings.vim.notify = {
      nvim-notify = {
        enable = true;
        setupOpts = {
          render = "default";
          stages = "fade";
          timeout = 1000;
        };
      };
    };
  };
}

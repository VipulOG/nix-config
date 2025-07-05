{
  lib,
  config,
  ...
}: let
  cfg = config.custom.programs.neovim;
in {
  config = lib.mkIf cfg.enable {
    programs.nvf.settings.vim.dashboard = {
      dashboard-nvim = {
        enable = true;
        setupOpts = {
          config = {
            week_header.enable = true;
            packages.enable = false;
            shortcut = lib.mkForce {};
            footer = lib.mkForce {};
          };
        };
      };
    };
  };
}

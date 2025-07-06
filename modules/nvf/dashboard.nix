{lib, ...}: {
  config.vim.dashboard = {
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
}

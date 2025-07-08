{
  config.vim = {
    filetree.nvimTree = {
      enable = false;
      openOnSetup = false;
      mappings.toggle = "<leader>tt";

      setupOpts = {
        hijack_cursor = true;
        hijack_netrw = false;
        view.float.enable = false;
      };
    };
  };
}

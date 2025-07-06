{
  config.vim.binds = {
    hardtime-nvim.enable = false;
    whichKey = {
      enable = true;
      register = {
        "<leader>f" = "+Telescope";
        "<leader>fl" = "Telescope LSP";
        "<leader>fv" = "Telescope Git";
        "<leader>fvc" = "Commits";
        "<leader>b" = "+Buffer";
      };
    };
  };
}

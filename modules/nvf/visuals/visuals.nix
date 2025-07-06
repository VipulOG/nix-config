{
  config.vim.visuals = {
    rainbow-delimiters.enable = true;
    nvim-web-devicons.enable = true;

    indent-blankline = {
      enable = true;
      setupOpts = {
        exclude.filetypes = ["log" "txt" "md" "dashboard" "help"];
      };
    };

    cinnamon-nvim = {
      enable = true;
      setupOpts = {
        keymaps.basic = true;
      };
    };

    cellular-automaton = {
      enable = true;
      mappings.makeItRain = null;
    };
  };
}

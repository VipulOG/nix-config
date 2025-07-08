{
  config.vim = {
    utility = {
      surround = {
        enable = true;
        useVendoredKeybindings = false;
      };

      outline.aerial-nvim = {
        enable = true;
        mappings.toggle = "<C-W>a";
      };

      oil-nvim.enable = true;
    };

    keymaps = [
      {
        key = "-";
        mode = ["n"];
        action = "<CMD>Oil<CR>";
        desc = "Open parent directory";
      }
    ];
  };
}

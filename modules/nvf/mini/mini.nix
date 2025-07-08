{lib, ...}: {
  config.vim = {
    mini = {
      ai.enable = true;
      bracketed.enable = true;
      bufremove.enable = true;
      cursorword.enable = true;
      git.enable = true;
      jump.enable = true;
      jump2d.enable = true;
      move.enable = true;
      operators.enable = true;
      pairs.enable = true;
      splitjoin.enable = true;
      tabline.enable = true;
      trailspace.enable = true;

      basics = {
        enable = true;
        setupOpts = {
          options = {
            extra_ui = true;
          };
          mappings = {
            windows = true;
            move_with_alt = true;
          };
        };
      };
    };

    keymaps = [
      {
        key = "<leader>bd";
        mode = ["n"];
        action = "MiniBufremove.delete";
        lua = true;
        desc = "Delete buffer";
      }
      {
        key = "<leader>bw";
        mode = ["n"];
        action = "MiniBufremove.wipeout";
        lua = true;
        desc = "Wipeout buffer";
      }
    ];

    autocmds = [
      {
        event = ["FileType"];
        pattern = ["NvimTree"];
        desc = "Disable mini-cursorword in NvimTree";
        callback = lib.mkLuaInline ''
          function() vim.b.minicursorword_disable = true end
        '';
      }
    ];
  };
}

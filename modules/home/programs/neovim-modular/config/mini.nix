{
  lib,
  config,
  ...
}: let
  cfg = config.custom.programs.neovim;
in {
  config = lib.mkIf cfg.enable {
    programs.nvf.settings.vim.mini = {
      ai.enable = true;
      basics = {
        enable = true;
        setupOpts = {
          mappings = {
            windows = true;
            move_with_alt = true;
          };
        };
      };
      bracketed.enable = true;
      bufremove.enable = true;
      cursorword.enable = true;
      git.enable = true;
      indentscope = {
        enable = true;
        setupOpts = {
          ignore_filetypes = ["log" "txt" "md" "dashboard" "help"];
          draw.animation = lib.mkLuaInline "require('mini.indentscope').gen_animation.none()";
        };
      };
      jump.enable = true;
      jump2d.enable = true;
      move.enable = true;
      operators.enable = true;
      pairs.enable = true;
      splitjoin.enable = true;
      tabline.enable = true;
      trailspace.enable = true;
    };
    programs.nvf.settings.vim.keymaps = [
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
  };
}

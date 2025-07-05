{
  lib,
  config,
  ...
}: let
  cfg = config.custom.programs.neovim;
in {
  config = lib.mkIf cfg.enable {
    programs.nvf.settings.vim.ui = {
      borders = {
        enable = true;
        globalStyle = "rounded";
      };
      smartcolumn = {
        enable = true;
        setupOpts = {
          disabled_filetypes = ["dashboard"];
        };
      };
      breadcrumbs = {
        enable = true;
        navbuddy.enable = true;
        lualine.winbar = {
          enable = true;
          alwaysRender = false;
        };
      };
      noice = {
        enable = true;
        setupOpts = {
          lsp.signature.enabled = true;
          presets = {
            bottom_search = true;
            command_palette = true;
            long_message_to_split = true;
            inc_rename = true;
            lsp_doc_border = true;
          };
          routes = [
            {
              filter = {
                event = "msg_show";
                kind = "";
                find = "written";
              };
              opts = {skip = true;};
            }
          ];
        };
      };
    };
  };
}

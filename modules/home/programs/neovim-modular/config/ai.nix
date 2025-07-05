{
  lib,
  config,
  ...
}: let
  cfg = config.custom.programs.neovim;
in {
  config = lib.mkIf cfg.enable {
    programs.nvf.settings.vim.assistant.codecompanion-nvim = {
      enable = true;
      setupOpts = {
        adapters = lib.mkLuaInline ''
          {
            gemini = function()
              return require("codecompanion.adapters").extend("gemini", {
                env = {
                  api_key = "",
                },
                schema = {
                  model = {
                    default = "gemini-2.0-flash",
                  },
                },
              })
            end
          }
        '';
        strategies = {
          chat.adapter = "gemini";
          inline.adapter = "gemini";
          cmd.adapter = "gemini";
        };
        opts.send_code = true;
        display.chat.auto_scroll = true;
      };
    };
  };
}

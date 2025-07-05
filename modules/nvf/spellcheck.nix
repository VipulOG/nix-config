{
  lib,
  config,
  ...
}: let
  cfg = config.custom.programs.neovim;
in {
  config = lib.mkIf cfg.enable {
    programs.nvf.settings.vim.spellcheck = {
      enable = true;
      languages = ["en"];
      programmingWordlist.enable = true;
    };
  };
}

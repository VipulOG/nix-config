{
  lib,
  config,
  ...
}: let
  cfg = config.custom.programs.neovim;
in {
  config = lib.mkIf cfg.enable {
    programs.nvf.settings.vim = {
      vimAlias = true;
      viAlias = true;
      withNodeJs = true;
    };
  };
}

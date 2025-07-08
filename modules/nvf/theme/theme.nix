{
  config,
  lib,
  ...
}: let
  themeLib = import ./lib.nix {inherit lib;};
  baseColors = themeLib.color.base16Colors config;
in {
  config.vim = {
    theme = {
      enable = true;
      name = "base16";
      base16-colors = baseColors;
    };

    highlight = {
      WinSeparator = {fg = baseColors.base02;};
      LineNr = {fg = baseColors.base03;};
      CursorLineNr = {fg = baseColors.base04;};
      Pmenu = {bg = baseColors.base00;};
    };
  };
}

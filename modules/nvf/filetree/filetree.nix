{
  lib,
  config,
  ...
}: let
  themeLib = import ../theme/lib.nix {inherit lib;};
  colors = themeLib.color.base16Colors config;
  inherit (themeLib.color) darken;
in {
  config.vim = {
    filetree.nvimTree = {
      enable = true;
      openOnSetup = false;
      mappings.toggle = "<leader>tt";

      setupOpts = {
        hijack_cursor = true;
        hijack_netrw = false;
        view.float.enable = false;
      };
    };

    highlight = {
      NvimTreeNormal.bg = darken colors.base00 0.1;
    };
  };
}

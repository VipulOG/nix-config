{
  pkgs,
  lib,
  inputs,
  ...
}:
(inputs.nvf.lib.neovimConfiguration {
  inherit pkgs;
  modules = [];
}).neovim

{
  pkgs,
  lib,
  inputs,
  self,
  ...
}:
(inputs.nvf.lib.neovimConfiguration {
  inherit pkgs;
  modules = [
    self.commonModules.default
    self.nvfModules.default
  ];
}).neovim

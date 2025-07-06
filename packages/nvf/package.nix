{
  pkgs,
  inputs,
  self,
  ...
}:
(inputs.nvf.lib.neovimConfiguration {
  inherit pkgs;
  modules = [
    self.nvfModules.default
    self.commonModules.default
  ];
  extraSpecialArgs = {inherit inputs;};
}).neovim

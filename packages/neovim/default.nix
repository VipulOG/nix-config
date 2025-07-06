{
  inputs,
  self,
  ...
}: {
  perSystem = {pkgs, ...}: {
    packages.neovim = pkgs.callPackage ./package.nix {
      inherit self inputs;
    };
  };
}

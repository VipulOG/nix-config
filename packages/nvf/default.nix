{
  inputs,
  self,
  ...
}: {
  perSystem = {pkgs, ...}: {
    packages.nvf = pkgs.callPackage ./package.nix {
      inherit self inputs;
    };
  };
}

{
  perSystem = {
    pkgs,
    self,
    inputs,
    ...
  }: {
    packages.nvf = pkgs.callPackage ./package.nix {
      inherit self inputs;
    };
  };
}

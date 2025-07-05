{
  perSystem = {pkgs, ...}: {
    packages.neovim = pkgs.callPackage ./package.nix {};
  };
}

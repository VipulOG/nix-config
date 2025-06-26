{
  perSystem = {pkgs, ...}: {
    packages.whatsapp-web = pkgs.callPackage ./package.nix {};
  };
}

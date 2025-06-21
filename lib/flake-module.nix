{lib, ...}: {
  flake = {
    lib = import ./lib.nix {inherit lib;};
  };
}

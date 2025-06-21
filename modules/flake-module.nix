{
  flake = {
    nixosModules.default = ./nixos;
    homeModules.default = ./home-manager;
    commonModules.default = ./common;
  };
}

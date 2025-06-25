{
  flake = {
    nixosModules.default = ./nixos;
    homeModules.default = ./home;
    commonModules.default = ./common;
  };
}

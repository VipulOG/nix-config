{
  flake = {
    nixosModules.default = ./nixos;
    homeModules.default = ./home;
    nvfModules.default = ./nvf;
    commonModules.default = ./common;
  };
}

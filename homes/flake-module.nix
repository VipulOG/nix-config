{
  withSystem,
  inputs,
  self,
  lib,
  ...
}:
with lib; let
  # Creates a home-manager configuration for a specific home
  # system: Architecture (e.g., "x86_64-linux")
  # home: home-configuration name
  # Returns: A home-manager configuration
  mkHomeConfig = system: home: (
    withSystem system (
      ctx: (
        inputs.home-manager.lib.homeManagerConfiguration {
          inherit (ctx) pkgs;
          extraSpecialArgs = {
            inherit (ctx) inputs' self' pkgs pkgsStable pkgsUnstable;
            inherit inputs system home self;
          };
          modules = [
            self.homeModules.default
            self.commonModules.default
            ./${system}/${home}
          ];
        }
      )
    )
  );

  # Returns all system architectures available for our homes.
  # Example: getSystems might return ["x86_64-linux" "aarch64-linux"]
  # if those system directories exist
  getSystems = pipe (builtins.readDir ./.) [
    # Filter to only include directories (each directory = one system)
    (filterAttrs (_: type: type == "directory"))
    # Extract just the directory names (system names)
    attrNames
  ];

  # Returns all homes for a given system
  # Example: getHomesForSystem "x86_64-linux" might return ["vipul" "guest"]
  getHomesForSystem = system: (
    pipe (builtins.readDir ./${system}) [
      (filterAttrs (_: type: type == "directory"))
      attrNames
    ]
  );

  # This function dynamically creates home-manager configurations for all
  # detected systems and their respective homes.
  makeHomeConfigurations = pipe getSystems [
    (map (system: (pipe (getHomesForSystem system) [
      (map (home: {
        name = home;
        value = mkHomeConfig system home;
      }))
    ])))
    flatten
    listToAttrs
  ];
in {
  flake = {
    homeConfigurations = makeHomeConfigurations;
  };
}

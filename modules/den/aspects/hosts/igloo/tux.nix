{
  den.aspects.igloo.tux = {
    nixos = {
      sops.secrets.tux-password = {
        neededForUsers = true;
      };
    };

    user = {config, ...}: {
      hashedPasswordFile = config.sops.secrets.tux-password.path;
    };

    homeManager = {
      home.stateVersion = "26.05";
    };
  };
}

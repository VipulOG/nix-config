{
  den.aspects.sudo = {
    nixos = {
      security.sudo.enable = true;
    };

    preservation.preserve.directories = [
      "/var/db/sudo"
    ];
  };
}

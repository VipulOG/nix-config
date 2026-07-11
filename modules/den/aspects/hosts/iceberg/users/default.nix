{den, ...}: {
  den.aspects.iceberg.users = {
    includes = [
      den.aspects.sops-nix
      den.aspects.niri-de
    ];
  };
}

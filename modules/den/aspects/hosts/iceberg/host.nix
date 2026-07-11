{
  den,
  lib,
  ...
}: {
  den = {
    aspects.iceberg = {
      includes = [
        den.policies.iceberg-to-users
        den.policies.iceberg-to-tux
        den.aspects.iceberg.hardware
        den.aspects.iceberg.disko
        den.aspects.ephemeral-host
        den.aspects.sudo
      ];

      nixos = {
        lib,
        config,
        ...
      }: {
        boot.loader = {
          systemd-boot.enable = true;
          efi.canTouchEfiVariables = true;
        };

        networking = {
          useDHCP = lib.mkDefault true;
          networkmanager.enable = true;
        };

        ephemeral-host = let
          mainDiskCfg = config.disko.devices.disk.main;
          subVols = mainDiskCfg.content.partitions.root.content.subvolumes;
        in {
          enable = true;
          nixMountpoint = subVols.nix.mountpoint;
          persistentMountpoint = subVols.persistent.mountpoint;
        };

        system.stateVersion = "26.05";
      };

      preservation.preserve.directories = [
        "/var/lib/systemd"
        "/var/lib/NetworkManager"
        "/etc/NetworkManager/system-connections"

        "/var/log"
      ];
    };

    policies.iceberg-to-users = {
      host,
      user,
      ...
    }:
      lib.optional
      (host.name == "iceberg" && user != null)
      (den.lib.policy.include den.aspects.iceberg.users);

    policies.iceberg-to-tux = {
      host,
      user,
      ...
    }:
      lib.optional
      (host.name == "iceberg" && user.name == "tux")
      (den.lib.policy.include den.aspects.iceberg.users.tux);
  };
}

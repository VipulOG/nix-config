{den, ...}: {
  den.aspects.iceberg = {
    includes = [
      den.aspects.iceberg.hardware
      den.aspects.iceberg.disko
      den.aspects.ephemeral-host
      den.aspects.sops-nix
      den.aspects.sudo
      den.aspects.podman
      den.aspects.niri-de
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

    persist = {
      preserve.directories = [
        "/var/lib/systemd"
        "/var/lib/NetworkManager"
        "/etc/NetworkManager/system-connections"

        "/var/log"
      ];
    };
  };
}

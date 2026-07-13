{den, ...}: {
  den = {
    aspects.igloo = {
      includes = [
        den.aspects.igloo.hardware
        den.aspects.igloo.disko
        den.aspects.ephemeral-host
        den.aspects.sops-nix
        den.aspects.sudo
        den.aspects.podman
        den.aspects.niri-de
      ];

      nixos = {config, ...}: {
        boot.loader = {
          systemd-boot.enable = true;
          efi.canTouchEfiVariables = true;
        };

        hardware.bluetooth.enable = true;
        networking.networkmanager.enable = true;
        services.blueman.enable = true;

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
        "/var/lib/bluetooth"
        "/var/lib/NetworkManager"
        "/etc/NetworkManager/system-connections"

        "/var/log"
      ];
    };
  };
}

{
  den,
  lib,
  ...
}: {
  den = {
    aspects.igloo = {
      includes = [
        den.policies.igloo-to-users
        den.policies.igloo-to-tux
        den.aspects.igloo.hardware
        den.aspects.igloo.disko
        den.aspects.ephemeral-host
        den.aspects.sudo
        den.aspects.podman
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

    policies.igloo-to-users = {
      host,
      user,
      ...
    }:
      lib.optional
      (host.name == "igloo" && user != null)
      (den.lib.policy.include den.aspects.igloo.users);

    policies.igloo-to-tux = {
      host,
      user,
      ...
    }:
      lib.optional
      (host.name == "igloo" && user.name == "tux")
      (den.lib.policy.include den.aspects.igloo.users.tux);
  };
}

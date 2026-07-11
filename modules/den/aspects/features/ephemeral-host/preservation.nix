{inputs, ...}: {
  flake-file.inputs = {
    preservation.url = "github:nix-community/preservation";
  };

  den.aspects.ephemeral-host.preservation = {user}: {
    nixos = {
      lib,
      config,
      options,
      ...
    }: let
      hostCfg = config.ephemeral-host;
      cfg = config.preservation;
      inherit (cfg) defaultPreserveAt;
    in {
      imports = [inputs.preservation.nixosModules.default];

      options.preservation = {
        preserve = lib.mkOption {
          type = options.preservation.preserveAt.type.nestedTypes.elemType;
          default = {};
        };

        defaultPreserveAt = lib.mkOption {
          type = lib.types.str;
          default = hostCfg.persistentMountpoint;
        };
      };

      config = lib.mkIf hostCfg.enable {
        preservation = {
          enable = true;

          preserveAt.${defaultPreserveAt} =
            lib.mkAliasDefinitions options.preservation.preserve;

          preserve.persistentStoragePath = defaultPreserveAt;
        };

        systemd.services.systemd-machine-id-commit = {
          unitConfig.ConditionPathIsMountPoint = [
            ""
            "${defaultPreserveAt}/etc/machine-id"
          ];

          serviceConfig.ExecStart = [
            ""
            "systemd-machine-id-setup --commit --root ${defaultPreserveAt}"
          ];
        };
      };
    };

    preservation = {
      preserve = {
        directories = [
          {
            directory = "/var/lib/nixos";
            inInitrd = true;
          }

          "/etc/nixos"
        ];

        files = [
          {
            file = "/etc/machine-id";
            inInitrd = true;
            how = "symlink";
          }
        ];

        users.${user.name}.directories = [
          {
            directory = "Documents";
            mode = "0700";
          }

          {
            directory = "Pictures";
            mode = "0700";
          }

          {
            directory = "Videos";
            mode = "0700";
          }

          {
            directory = "Dev";
            mode = "0700";
          }

          {
            directory = ".cache/mesa_shader_cache";
            mode = "0700";
          }
        ];
      };
    };
  };
}

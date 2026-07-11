{
  den,
  inputs,
  ...
}: {
  flake-file.inputs = {
    dms = {
      url = "github:AvengeMedia/DankMaterialShell/stable";
      inputs.nixpkgs.follows = "nixpkgs";
    };
  };

  den.aspects.niri-de.dms = {user}: {
    includes = with den.aspects.niri-de.dms; [
      settings
      niri
      alacritty
    ];

    nixos = {pkgs, ...}: {
      imports = [inputs.dms.nixosModules.dank-material-shell];

      services.upower.enable = true;

      programs.dank-material-shell = {
        enable = true;

        quickshell.package = pkgs.quickshell;

        enableVPN = true;
        enableCalendarEvents = true;
        enableClipboardPaste = true;
        enableDynamicTheming = true;
        enableAudioWavelength = true;
        enableSystemMonitoring = true;

        systemd = {
          enable = true;
          restartIfChanged = true;
        };
      };
    };

    homeManager = {pkgs, ...}: {
      imports = [inputs.dms.homeModules.dank-material-shell];

      programs.dank-material-shell = {
        enable = true;
        quickshell.package = pkgs.quickshell;
      };
    };

    preservation = {
      preserve.users.${user.name}.directories = [
        {
          directory = ".config/DankMaterialShell";
          mode = "0700";
        }

        {
          directory = ".local/state/DankMaterialShell";
          mode = "0700";
        }

        {
          directory = ".cache/DankMaterialShell";
          mode = "0700";
        }

        {
          directory = ".cache/quickshell";
          mode = "0700";
        }

        {
          directory = ".local/share/color-schemes";
          mode = "0700";
        }
      ];
    };
  };
}

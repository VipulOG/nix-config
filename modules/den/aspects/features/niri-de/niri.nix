{inputs, ...}: {
  flake-file.inputs = {
    niri = {
      url = "github:sodiboo/niri-flake";
      inputs.nixpkgs.follows = "nixpkgs";
    };
  };

  den.aspects.niri-de.niri = {
    nixos = {
      programs.niri = {
        enable = true;
      };
    };

    homeManager = {pkgs, ...}: {
      imports = [
        inputs.niri.homeModules.niri
        (import ./_workarounds/niri-raw-config.nix inputs.niri.lib)
      ];

      programs.niri = {
        enable = true;
        package = pkgs.niri;

        settings = {
          prefer-no-csd = true;

          hotkey-overlay = {
            skip-at-startup = true;
          };

          environment = {
            XDG_CURRENT_DESKTOP = "niri";
            QT_QPA_PLATFORMTHEME = "gtk3";
          };

          outputs = {
            "eDP-1" = {
              mode = {
                width = 1920;
                height = 1080;
                refresh = 60.0;
              };

              scale = 1.25;
            };
          };

          layer-rules = [
            {
              matches = [{namespace = "^quickshell$";}];
              place-within-backdrop = true;
            }
          ];

          window-rules = [
            {
              geometry-corner-radius = {
                top-left = 6.0;
                top-right = 6.0;
                bottom-left = 6.0;
                bottom-right = 6.0;
              };

              clip-to-geometry = true;
              tiled-state = true;
              draw-border-with-background = false;
            }

            {
              matches = [
                {app-id = "^gnome-calculator$";}
                {app-id = "^galculator$";}
                {app-id = "^blueman-manager$";}
                {app-id = "^org\\.gnome\\.Nautilus$";}
                {app-id = "^xdg-desktop-portal$";}
                {app-id = "zoom";}
                {app-id = "org.quickshell$";}
                {app-id = "com.danklinux.dms$";}

                {
                  app-id = "firefox$";
                  title = "^Picture-in-Picture$";
                }
              ];

              open-floating = true;
            }

            {
              matches = [
                {
                  app-id = "^steam$";
                  title = "^notificationtoasts_\\d+_desktop$";
                }
              ];

              default-floating-position = {
                x = 10;
                y = 10;
                relative-to = "bottom-right";
              };

              open-focused = false;
            }

            {
              matches = [
                {
                  app-id = "Alacritty";
                  at-startup = true;
                }
              ];

              open-on-workspace = "1-dev";
              default-column-width.proportion = 0.66666;
            }

            {
              matches = [
                {
                  app-id = "^org.qutebrowser.qutebrowser$";
                  at-startup = true;
                }
              ];

              open-on-workspace = "1-dev";
              open-focused = false;
              default-column-width.proportion = 0.33333;
            }

            {
              matches = [
                {
                  app-id = "^firefox$";
                  at-startup = true;
                }
              ];

              open-on-workspace = "2-web";
            }
          ];

          workspaces = {
            "1-dev" = {};
            "2-web" = {};
          };

          spawn-at-startup = [
            {argv = ["alacritty"];}
            {argv = ["qutebrowser"];}
            {argv = ["firefox"];}
          ];
        };
      };
    };
  };
}

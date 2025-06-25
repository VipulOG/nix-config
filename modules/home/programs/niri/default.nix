{
  lib,
  pkgs,
  self,
  config,
  inputs,
  inputs',
  ...
}:
with lib; let
  cfg = config.internal.programs.niri;
  colors = config.lib.stylix.colors.withHashtag;

  ACTIVE_BORDER_COLOR = colors.base0D;
  INACTIVE_BORDER_COLOR = colors.base03;

  CLIPSE_EXE = getExe' pkgs.clipse "clipse";
  CURSOR_NAME = config.stylix.cursor.name;
  CURSOR_SIZE = toString config.stylix.cursor.size;
  FLOCK_EXE = getExe' pkgs.util-linux "flock";
  GHOSTTY_EXE = getExe' pkgs.ghostty "ghostty";
  SWAYOSD_CLIENT_EXE = getExe' pkgs.swayosd "swayosd-client";
  SWAYBG_EXE = getExe' pkgs.swaybg "swaybg";
  WALLPAPER = self.lib.relativeToRoot "assets/wallpapers/wallpaper.jpg";
  WOFI_EXE = getExe' pkgs.wofi "wofi";
  XWAYLAND_SATELLITE_EXE = getExe' pkgs.xwayland-satellite "xwayland-satellite";

  startupCommands = flatten (
    lib.optionals config.internal.programs.ghostty.enable [
      "spawn-at-startup \"${GHOSTTY_EXE}\""
    ]
    ++ lib.optionals config.internal.programs.zen-browser.enable [
      "spawn-at-startup \"${getExe inputs'.zen-browser.packages.default}\""
    ]
    ++ lib.optionals config.internal.programs.whatsapp-web.enable [
      "spawn-at-startup \"${config.internal.programs.whatsapp-web.exe}\""
    ]
    ++ lib.optionals config.internal.programs.btop.enable [
      "spawn-at-startup \"${GHOSTTY_EXE}\" \"--command=${getExe pkgs.btop}\" \"--title=btop\""
    ]
  );

  baseConfig = ''
    input {
        keyboard {
            xkb {
                layout ""
                model ""
                rules ""
                variant ""
            }
            repeat-delay 600
            repeat-rate 25
            track-layout "global"
        }

        touchpad {
            tap
            natural-scroll
            accel-speed 0.0
        }

        mouse {
            accel-speed 0.0
        }

        trackpoint {
            accel-speed 0.0
        }

        trackball {
            accel-speed 0.0
        }

        tablet
        touch
    }

    screenshot-path "~/Pictures/Screenshots/%Y-%m-%d_%H-%M-%S.png"
    prefer-no-csd

    layout {
        gaps 10
        struts {
            left 0
            right 0
            top 0
            bottom 0
        }

        focus-ring {
            off
        }

        border {
            width 4
            active-color "${ACTIVE_BORDER_COLOR}"
            inactive-color "${INACTIVE_BORDER_COLOR}"
        }

        shadow {
            on
            offset x=0 y=0
            softness 8
            spread 4
            draw-behind-window false
            color "#00000070"
        }

        tab-indicator {
            gap 4
            width 10
            length total-proportion=0.5
            position "bottom"
            gaps-between-tabs 4
            corner-radius 0
        }

        insert-hint {
            color "rgb(127 200 255 / 50%)"
        }

        default-column-width
        center-focused-column "never"
    }

    cursor {
        xcursor-theme "${CURSOR_NAME}"
        xcursor-size ${CURSOR_SIZE}
    }

    hotkey-overlay {
        skip-at-startup
    }

    environment {
        DISPLAY ":0"
    }

    // Workspaces
    workspace "system-monitor"
    workspace "code"
    workspace "web"
    workspace "chat"

    // Startup Programs
    spawn-at-startup "${XWAYLAND_SATELLITE_EXE}"
    spawn-at-startup "${SWAYBG_EXE}" "-i" "${WALLPAPER}"
    spawn-at-startup "systemctl" "--user" "restart" "xdg-desktop-portal-gnome"
    spawn-at-startup "systemctl" "--user" "restart" "swayidle"
    spawn-at-startup "systemctl" "--user" "restart" "swayosd"
    spawn-at-startup "systemctl" "--user" "restart" "clipse"

    // Window Rules
    window-rule {
        open-maximized true
        geometry-corner-radius 0.0 0.0 0.0 0.0
        clip-to-geometry true
    }

    window-rule {
        match at-startup=true app-id="com.mitchellh.ghostty"
        open-on-workspace "code"
    }

    window-rule {
        match at-startup=true app-id="^zen"
        open-on-workspace "web"
    }

    window-rule {
        match at-startup=true app-id="^chrome-web.whatsapp.com"
        open-on-workspace "chat"
    }

    window-rule {
        match at-startup=true title="btop"
        open-on-workspace "system-monitor"
    }

    window-rule {
        match title="clipse"
        open-floating true
    }

    // Layer Rules
    layer-rule {
        match namespace="^notifications$"
        block-out-from "screencast"
    }

    // Keybindings
    binds {
        // Workspace Navigation
        Mod+U { focus-workspace-down }
        Mod+I { focus-workspace-up }
        Mod+Ctrl+U { move-column-to-workspace-down }
        Mod+Ctrl+I { move-column-to-workspace-up }
        Mod+Shift+U { move-workspace-down }
        Mod+Shift+I { move-workspace-up }
        Mod+0 { focus-workspace "system-monitor" }
        Mod+1 { focus-workspace "code" }
        Mod+2 { focus-workspace "web" }
        Mod+3 { focus-workspace "chat" }
        Mod+4 { focus-workspace 5 }
        Mod+Ctrl+0 { move-window-to-workspace "system-monitor" }
        Mod+Ctrl+1 { move-window-to-workspace "code" }
        Mod+Ctrl+2 { move-window-to-workspace "web" }
        Mod+Ctrl+3 { move-window-to-workspace "chat" }
        Mod+Ctrl+4 { move-window-to-workspace 5 }

        // Monitor Navigation
        Mod+Shift+L { focus-monitor-right }
        Mod+Shift+H { focus-monitor-left }
        Mod+Shift+J { focus-monitor-down }
        Mod+Shift+K { focus-monitor-up }
        Mod+Ctrl+Shift+L { move-column-to-monitor-right }
        Mod+Ctrl+Shift+H { move-column-to-monitor-left }
        Mod+Ctrl+Shift+J { move-column-to-monitor-down }
        Mod+Ctrl+Shift+K { move-column-to-monitor-up }

        // Column Management
        Mod+R { switch-preset-column-width }
        Mod+F { maximize-column }
        Mod+Ctrl+F { expand-column-to-available-width }
        Mod+C { center-column }
        Mod+L { focus-column-right }
        Mod+H { focus-column-left }
        Mod+Ctrl+L { move-column-right }
        Mod+Ctrl+H { move-column-left }
        Mod+Minus { set-column-width "-10%" }
        Mod+Equal { set-column-width "+10%" }
        Mod+W { toggle-column-tabbed-display }

        // Window Management
        Mod+Shift+R { switch-preset-window-height }
        Mod+Ctrl+R { reset-window-height }
        Mod+Shift+F { fullscreen-window }
        Mod+Q { close-window }
        Mod+J { focus-window-down }
        Mod+K { focus-window-up }
        Mod+Ctrl+J { move-window-down-or-to-workspace-down }
        Mod+Ctrl+K { move-window-up-or-to-workspace-up }
        Mod+Shift+Minus { set-window-height "-10%" }
        Mod+Shift+Equal { set-window-height "+10%" }
        Mod+Comma { consume-window-into-column }
        Mod+Period { expel-window-from-column }
        Mod+BracketLeft { consume-or-expel-window-left }
        Mod+BracketRight { consume-or-expel-window-right }
        Mod+V { toggle-window-floating }
        Mod+Shift+V { switch-focus-between-floating-and-tiling }

        // System Actions
        Mod+Shift+E { quit }
        Ctrl+Alt+Delete { quit }
        Mod+Shift+Slash { show-hotkey-overlay }

        Mod+Space {
            spawn "sh" "-c" "${FLOCK_EXE} -n /tmp/wofi.lock ${WOFI_EXE} --show drun"
        }

        // Volume Control
        XF86AudioMicMute {
            spawn "${SWAYOSD_CLIENT_EXE}" "--input-volume" "mute-toggle"
        }
        XF86AudioMute {
            spawn "${SWAYOSD_CLIENT_EXE}" "--output-volume" "mute-toggle"
        }
        XF86AudioRaiseVolume {
            spawn "${SWAYOSD_CLIENT_EXE}" "--output-volume" "raise"
        }
        XF86AudioLowerVolume {
            spawn "${SWAYOSD_CLIENT_EXE}" "--output-volume" "lower"
        }
        Mod+F9 {
            spawn "${SWAYOSD_CLIENT_EXE}" "--input-volume" "mute-toggle"
        }
        Mod+F10 {
            spawn "${SWAYOSD_CLIENT_EXE}" "--output-volume" "mute-toggle"
        }
        Mod+F11 {
            spawn "${SWAYOSD_CLIENT_EXE}" "--output-volume" "raise"
        }
        Mod+F12 {
            spawn "${SWAYOSD_CLIENT_EXE}" "--output-volume" "lower"
        }

        // Screenshots
        Print { screenshot }
        Mod+Print { screenshot-window }
        Mod+Shift+Print { screenshot-screen }

        // Applications
        Mod+T {
            spawn "${GHOSTTY_EXE}"
        }
        Mod+Ctrl+V {
            spawn "sh" "-c" "${GHOSTTY_EXE} --title=clipse --command=${CLIPSE_EXE}"
        }
    }
  '';
in {
  imports = [
    inputs.niri.homeModules.niri
  ];

  config = mkIf cfg.enable {
    nixpkgs.overlays = [inputs.niri.overlays.niri];
    programs.niri.config = baseConfig + concatLines startupCommands;
  };
}

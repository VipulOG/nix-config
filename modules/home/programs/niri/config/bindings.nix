{
  lib,
  pkgs,
  ...
}: let
  inherit (lib) getExe';

  launchAppLauncher = spawn (sh "${exes.flock} -n /tmp/wofi.lock ${exes.wofi} --show drun");
  launchGhostty = spawn ["${exes.ghostty}"];
  launchClipse = spawn (sh "${exes.ghostty} --title=clipse --command=${exes.clipse}");

  muteMic = spawn ["${exes.swayosdClient}" "--input-volume" "mute-toggle"];
  muteAudio = spawn ["${exes.swayosdClient}" "--output-volume" "mute-toggle"];
  lowerVolume = spawn ["${exes.swayosdClient}" "--output-volume" "lower"];
  raiseVolume = spawn ["${exes.swayosdClient}" "--output-volume" "raise"];

  exes = {
    clipse = getExe' pkgs.clipse "clipse";
    flock = getExe' pkgs.util-linux "flock";
    ghostty = getExe' pkgs.ghostty "ghostty";
    swayosdClient = getExe' pkgs.swayosd "swayosd-client";
    wofi = getExe' pkgs.wofi "wofi";
  };

  sh = command: ["sh" "-c" "${command}"];

  spawn = command_list: (
    lib.pipe command_list [
      (command_list: map (item: "\"" + item + "\"") command_list)
      (quoted_commands: lib.strings.concatStringsSep " " quoted_commands)
      (commands: "spawn ${commands}")
    ]
  );
in
  #kdl
  ''
    binds {
      //////////  Workspace Navigation  //////////
      Mod+U {
        focus-workspace-down
      }
      Mod+I {
        focus-workspace-up
      }
      Mod+Ctrl+U {
        move-column-to-workspace-down
      }
      Mod+Ctrl+I {
        move-column-to-workspace-up
      }
      Mod+Shift+U {
        move-workspace-down
      }
      Mod+Shift+I {
        move-workspace-up
      }
      Mod+0 {
        focus-workspace "system-monitor"
      }
      Mod+1 {
        focus-workspace "code"
      }
      Mod+2 {
        focus-workspace "web"
      }
      Mod+3 {
        focus-workspace "chat"
      }
      Mod+4 {
        focus-workspace 5
      }
      Mod+Ctrl+0 {
        move-window-to-workspace "system-monitor"
      }
      Mod+Ctrl+1 {
        move-window-to-workspace "code"
      }
      Mod+Ctrl+2 {
        move-window-to-workspace "web"
      }
      Mod+Ctrl+3 {
        move-window-to-workspace "chat"
      }
      Mod+Ctrl+4 {
        move-window-to-workspace 5
      }

      //////////  Monitor Navigation  //////////
      Mod+Shift+L {
        focus-monitor-right
      }
      Mod+Shift+H {
        focus-monitor-left
      }
      Mod+Shift+J {
        focus-monitor-down
      }
      Mod+Shift+K {
        focus-monitor-up
      }
      Mod+Ctrl+Shift+L {
        move-column-to-monitor-right
      }
      Mod+Ctrl+Shift+H {
        move-column-to-monitor-left
      }
      Mod+Ctrl+Shift+J {
        move-column-to-monitor-down
      }
      Mod+Ctrl+Shift+K {
        move-column-to-monitor-up
      }

      //////////  Column Management  //////////
      Mod+R {
        switch-preset-column-width
      }
      Mod+F {
        maximize-column
      }
      Mod+Ctrl+F {
        expand-column-to-available-width
      }
      Mod+C {
        center-column
      }
      Mod+L {
        focus-column-right
      }
      Mod+H {
        focus-column-left
      }
      Mod+Ctrl+L {
        move-column-right
      }
      Mod+Ctrl+H {
        move-column-left
      }
      Mod+Minus {
        set-column-width "-10%"
      }
      Mod+Equal {
        set-column-width "+10%"
      }
      Mod+W {
        toggle-column-tabbed-display
      }

      //////////  Window Management  //////////
      Mod+Shift+R {
        switch-preset-window-height
      }
      Mod+Ctrl+R {
        reset-window-height
      }
      Mod+Shift+F {
        fullscreen-window
      }
      Mod+Q {
        close-window
      }
      Mod+J {
        focus-window-down
      }
      Mod+K {
        focus-window-up
      }
      Mod+Ctrl+J {
        move-window-down-or-to-workspace-down
      }
      Mod+Ctrl+K {
        move-window-up-or-to-workspace-up
      }
      Mod+Shift+Minus {
        set-window-height "-10%"
      }
      Mod+Shift+Equal {
        set-window-height "+10%"
      }
      Mod+Comma {
        consume-window-into-column
      }
      Mod+Period {
        expel-window-from-column
      }
      Mod+BracketLeft {
        consume-or-expel-window-left
      }
      Mod+BracketRight {
        consume-or-expel-window-right
      }
      Mod+V {
        toggle-window-floating
      }
      Mod+Shift+V {
        switch-focus-between-floating-and-tiling
      }

      //////////  System Actions  //////////
      Mod+Shift+E {
        quit
      }
      Ctrl+Alt+Delete {
        quit
      }
      Mod+Shift+Slash {
        show-hotkey-overlay
      }
      Mod+Space {
        ${launchAppLauncher}
      }

      //////////  Volume Control  //////////
      XF86AudioMicMute {
        ${muteMic}
      }
      XF86AudioMute {
        ${muteAudio}
      }
      XF86AudioRaiseVolume {
        ${raiseVolume}
      }
      XF86AudioLowerVolume {
        ${lowerVolume}
      }
      Mod+F9 {
        ${muteMic}
      }
      Mod+F10 {
        ${muteAudio}
      }
      Mod+F11 {
        ${raiseVolume}
      }
      Mod+F12 {
        ${lowerVolume}
      }

      //////////  Screenshots  //////////
      Print {
        screenshot
      }
      Mod+Print {
        screenshot-window
      }
      Mod+Shift+Print {
        screenshot-screen
      }

      //////////  Applications  //////////
      Mod+T {
        ${launchGhostty}
      }
      Mod+Ctrl+V {
        ${launchClipse}
      }
    }
  ''

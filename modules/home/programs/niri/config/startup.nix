{
  lib,
  config,
  pkgs,
  inputs',
  ...
}: let
  inherit (lib) getExe';

  launchGhostty = spawn ["${exes.ghostty}"];
  launchZenBrowser = spawn ["${exes.zenBrowser}"];
  launchWhatsappWeb = spawn ["${exes.whatsappWeb}"];
  launchBtop = spawn ["${exes.ghostty}" "--command=${exes.btop}" "--title=btop"];

  exes = {
    btop = getExe' pkgs.btop "btop";
    ghostty = getExe' pkgs.ghostty "ghostty";
    swaybg = getExe' pkgs.swaybg "swaybg";
    whatsappWeb = config.custom.programs.whatsapp-web.package;
    xwaylandSatellite = getExe' pkgs.xwayland-satellite "xwayland-satellite";
    zenBrowser = getExe' inputs'.zen-browser.packages.default "zen-browser";
  };

  spawn = command_list: (
    lib.pipe command_list [
      (command_list: map (item: "\"" + item + "\"") command_list)
      (quoted_commands: lib.strings.concatStringsSep " " quoted_commands)
      (commands: "spawn-at-startup ${commands}")
    ]
  );
in
  #kdl
  ''
    spawn-at-startup "${exes.xwaylandSatellite}"

    spawn-at-startup "systemctl" "--user" "restart" "xdg-desktop-portal-gnome"
    spawn-at-startup "systemctl" "--user" "restart" "swayidle"
    spawn-at-startup "systemctl" "--user" "restart" "swayosd"
    spawn-at-startup "systemctl" "--user" "restart" "clipse"

    ${launchGhostty}
    ${launchZenBrowser}
    ${launchWhatsappWeb}
    ${launchBtop}
  ''

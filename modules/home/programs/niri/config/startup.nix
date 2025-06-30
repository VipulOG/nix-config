{pkgs, ...} @ args: let
  inherit (import ./lib.nix args) spawn-at-startup;

  start-xwayland-satellite = spawn-at-startup {
    command = _: ["${pkgs.xwayland-satellite}/bin/xwayland-satellite"];
  };

  launch-ghostty = spawn-at-startup {
    programs = ["ghostty"];
    command = deps: ["${deps.ghostty}/bin/ghostty"];
  };

  launch-zen-browser = spawn-at-startup {
    programs = ["zen-browser"];
    command = deps: ["${deps.zen-browser}/bin/zen-beta"];
  };

  launch-whatsapp-web = spawn-at-startup {
    programs = ["whatsapp-web"];
    command = deps: ["${deps.whatsapp-web}/bin/whatsapp-web"];
  };

  launch-btop = spawn-at-startup {
    programs = ["ghostty" "btop"];
    command = deps: [
      "${deps.ghostty}/bin/ghostty"
      "--command=${deps.btop}/bin/btop"
      "--gtk-single-instance=true"
      "--title=btop"
      "--class=app.btop"
    ];
  };
in
  #kdl
  ''
    ${start-xwayland-satellite}

    spawn-at-startup "systemctl" "--user" "restart" "xdg-desktop-portal-gnome"
    spawn-at-startup "systemctl" "--user" "restart" "swayidle"
    spawn-at-startup "systemctl" "--user" "restart" "swayosd"
    spawn-at-startup "systemctl" "--user" "restart" "clipse"
    spawn-at-startup "systemctl" "--user" "restart" "wpaperd"

    ${launch-ghostty}
    ${launch-zen-browser}
    ${launch-whatsapp-web}
    ${launch-btop}
  ''

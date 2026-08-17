{den, ...}: {
  den.aspects.niri-de = {
    includes = with den.aspects.niri-de; [
      niri
      dms
      gtk
    ];

    homeManager = {pkgs, ...}: {
      home.packages = [
        pkgs.xwayland-satellite
        pkgs.wl-clipboard
      ];
    };
  };
}

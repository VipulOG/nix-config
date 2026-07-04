{den, ...}: {
  den.aspects.niri-de = {
    includes = with den.aspects.niri-de; [
      ly
      niri
      alacritty
      dms
    ];

    homeManager = {pkgs, ...}: {
      home.packages = [
        pkgs.xwayland-satellite
        pkgs.wl-clipboard
      ];
    };
  };
}

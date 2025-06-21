{
  pkgs,
  config,
  self,
  lib,
  ...
}: let
  cfg = config.custom.programs.flatpak;
in {
  options.custom.programs.flatpak = {
    enable = self.lib.mkCustomEnableOption "flatpak";
  };

  config = lib.mkIf cfg.enable {
    services.flatpak.enable = true;

    environment.systemPackages = [
      pkgs.flatpak
      pkgs.gnome-software
    ];

    systemd.services.flatpak-repo = {
      wantedBy = ["multi-user.target"];
      path = [pkgs.flatpak];
      script = "flatpak remote-add --if-not-exists flathub https://flathub.org/repo/flathub.flatpakrepo";
    };
  };
}

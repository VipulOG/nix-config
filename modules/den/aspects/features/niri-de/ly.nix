{
  den.aspects.niri-de.ly = {
    nixos = {lib, ...}: {
      services.displayManager.ly = {
        enable = true;
      };

      systemd.services.display-manager = {
        serviceConfig.TTYPath = lib.mkForce "/dev/tty2";
      };
    };
  };
}

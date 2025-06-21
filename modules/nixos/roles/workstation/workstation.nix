{
  config,
  self,
  lib,
  ...
}: let
  cfg = config.custom.roles.workstation;
in {
  options.custom.roles.workstation = {
    enable = self.lib.mkCustomEnableOption "workstation role";
  };

  config = lib.mkIf cfg.enable {
    custom = {
      system = {
        boot.enable = true;
        nix.enable = true;
        security.sudo.enable = true;
        time.enable = true;
        locale.enable = true;
        fonts.enable = true;
        autoUpdate.enable = true;
      };

      services = {
        dm.enable = true;
        audio.enable = true;
        networking.enable = true;
        openssh.enable = true;

        tailscale = {
          enable = true;
          enableSSH = true;
        };
      };

      de = {
        niri.enable = true;
      };

      programs = {
        zsh.enable = true;
        flatpak.enable = true;
        comma.enable = true;
      };
    };
  };
}

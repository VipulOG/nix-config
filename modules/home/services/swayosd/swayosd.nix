{
  lib,
  pkgs,
  config,
  self,
  ...
}: let
  cfg = config.custom.services.swayosd;
in {
  options.custom.services.swayosd = {
    enable = self.lib.mkCustomEnableOption "swayosd";
    package = lib.mkPackageOption pkgs "swayosd" {};
  };

  config = lib.mkIf cfg.enable {
    services.swayosd = {
      enable = true;
      inherit (cfg) package;
    };

    home.file.".config/swayosd/style.css".text =
      #css
      ''
        window#osd {
          padding: 6px;
          border-radius: 12px;
        }

        #container > image {
          -gtk-icon-transform: scale(0.8);
        }

        progressbar {
          min-height: 12px;
        }
      '';
  };
}

{
  lib,
  config,
  ...
}:
with lib; let
  cfg = config.internal.services.swayosd;
in {
  options.internal.services.swayosd = {
    enable = mkEnableOption "swayosd";
    package = lib.mkPackageOption pkgs "swayosd" {};
  };

  config = mkIf cfg.enable {
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

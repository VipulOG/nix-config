{
  pkgs,
  lib,
  ...
}: let
  chromiumExe = lib.getExe' pkgs.ungoogled-chromium "chromium";
in
  pkgs.stdenv.mkDerivation {
    pname = "whatsapp-web";
    version = "1.0.0";
    src = ./.;
    nativeBuildInputs = [pkgs.makeWrapper];

    installPhase = ''
      mkdir -p $out/bin
      makeWrapper ${chromiumExe} $out/bin/whatsapp-web \
        --add-flags "--user-data-dir=$XDG_DATA_HOME/whatsapp-web-profile" \
        --add-flags "--app=https://web.whatsapp.com"

      # Install .desktop file and icon
      mkdir -p $out/share/applications
      mkdir -p $out/share/icons/hicolor/scalable/apps
      cat > $out/share/applications/whatsapp-web.desktop <<EOF
      [Desktop Entry]
      Name=WhatsApp Web
      Exec=$out/bin/whatsapp-web
      Icon=whatsapp-web
      Type=Application
      Categories=Network;InstantMessaging;
      EOF

      cp ${./whatsapp-icon.svg} $out/share/icons/hicolor/scalable/apps/whatsapp-web.svg
    '';

    meta = with lib; {
      description = "Wrapper for WhatsApp Web as Chromium app";
      homepage = "https://web.whatsapp.com";
      platforms = platforms.linux;
    };
  }

{
  pkgs,
  lib,
  ...
}:
pkgs.stdenv.mkDerivation {
  pname = "whatsapp-web";
  version = "1.0.0";
  src = ./.;
  nativeBuildInputs = [pkgs.makeWrapper];

  installPhase = ''
    mkdir -p $out/bin

    makeWrapper ${pkgs.brave}/bin/brave $out/bin/whatsapp-web \
      --add-flags "--app=https://web.whatsapp.com" \
      --add-flags "--user-data-dir=$HOME/.whatsapp-web-data" \
      --add-flags "--no-first-run" \
      --add-flags "--class=com.whatsapp.web" \
      --add-flags "--disable-features=TranslateUI"

    install -Dm644 ${./whatsapp-web.desktop} \
      $out/share/applications/whatsapp-web.desktop

    install -Dm644 ${./whatsapp-icon.svg} \
      $out/share/icons/hicolor/scalable/apps/whatsapp-web.svg
  '';

  meta = with lib; {
    description = "Brave wrapper for WhatsApp Web in app mode";
    homepage = "https://web.whatsapp.com";
    platforms = platforms.linux;
  };
}

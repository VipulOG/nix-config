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
    install -Dm755 ${./whatsapp-web.sh} $out/bin/whatsapp-web

    wrapProgram $out/bin/whatsapp-web --prefix PATH : ${pkgs.brave}/bin

    install -Dm644 ${./whatsapp-web.desktop} \
      $out/share/applications/whatsapp-web.desktop

    install -Dm644 ${./whatsapp-icon.svg} \
      $out/share/icons/hicolor/scalable/apps/whatsapp-web.svg
  '';

  meta = with lib; {
    description = "Standalone WhatsApp Web launcher using Brave Browser’s app mode";
    homepage = "https://web.whatsapp.com";
    platforms = platforms.linux;
  };
}

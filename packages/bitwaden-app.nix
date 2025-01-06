# bitwarden-app.nix
# This downloads and installs the bitwarden desktop application
{ stdenv, fetchurl, appImageTools, makeDesktopItem, lib ? stdenv.lib }:
{
  name = "bitwarden-appimage";
  version = "24.12.1";

  src = fetchurl {
    url = "https://vault.bitwarden.com/download/?app=desktop&platform=linux&variant=appimage";
    sha256 = "sha256-3b0bc9f1136d9552db213467155c210d7a4f96744c845321c6630ba0290d56d7";
  };

  insallPhase = ''
                mkdir -p $out/bin
                cp $src $out/bin/bitwarden-appimage
                chmod +x $out/bin/bitwarden-appimage
                '';
  desktopItem = makeDesktopItem {
    name = "Bitwarden";
    exec = "bitwarden-appimage";
    icon = "";
    type = "Application";
    categories = "Accessories";
  };
}

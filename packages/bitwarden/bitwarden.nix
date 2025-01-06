# bitwarden-app.nix
# This downloads and installs the bitwarden desktop application
{ stdenv, fetchurl, makeDesktopItem, lib ? stdenv.lib, appImageName ? "Bitwarden-2024.12.1-x86_64.AppIimage" }:
stdenv.mkDerivation {
  name = "Bitwarden-AppIimage";
  version = "24.12.1";
  dontUnpack = true;

  src = fetchurl {
    name = appImageName;
    url = "https://vault.bitwarden.com/download/?app=desktop&platform=linux&variant=appimage";
    sha256 = "1msn1lls02v3qqhm712cfjb4yyhd45f1arrl47dm55bd2gqwj2rv";
  };

  installPhase = ''
                 mkdir -p $out/bin
                 cp $src $out/bin/${appImageName}
                 chmod +x $out/bin/${appImageName}
                 '';
  desktopItem = makeDesktopItem {
    name = "Bitwarden";
    desktopName = "Bitwarden";
    exec = "${appImageName}";
    icon = "bitwarden";
    type = "Application";
    categories = ["Utility"];
    };
}
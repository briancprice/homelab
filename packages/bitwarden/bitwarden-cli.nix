# bitwarden-cli.nix
# This downloads and installs the bitwarden command-line utility
{ stdenv, fetchurl, makeDesktopItem, lib ? stdenv.lib }:
if true then throw error "The Bitwarden command-line utility doesn't work with nixos, you must build it from source." 
else stdenv.mkDerivation {
  name = "bitwarden-cli";
  version = "24.12.1";
  dontUnpack = true;
  src = fetchurl {
    name = "bw";
    url = "https://vault.bitwarden/download?app=cli&platform=linux";

    # nix-prefetch-url --print-path "https://vault.bitwarden.com/download?app=cli&platform=linux" --name bw-clitemp
    sha256 = "11fhp76kxl3zw8kxg4k6lgmx8k0x1z0kf4252gg8m8fwfv3rmv2d";
  };

  # Move the bw file to the bin directory
  installPhase = ''
                 mkdir -p $out/bin
                 cp $src $out/bin/bw
                 chmod +x $out/bin/bw
                 '';
 }
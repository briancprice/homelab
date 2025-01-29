# nixos.nix - Nixos settings
{ config, pkgs, lib, namespace, ... }: with lib; {

  imports = [
    ./localization.nix
    ./flatpak.nix
    ./networking.nix
    ({config, namespace, ...}: with lib; {
      config.${namespace}.homelab.settings = {
        flatpak.enable = mkDefault false;
        localization.enable = mkDefault true;
        networking.enable = mkDefault false;
      };
    })
  ];

  config = {
    # Add time servers...
    networking.timeServers = [ "time.google.com" "time.cloudflare.com" ];
  };
}

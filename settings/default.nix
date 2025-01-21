# nixos.nix - Nixos settings
{ config, pkgs, lib, namespace, ... }: with lib; {
  imports = [
    ./localization.nix
    ./flatpak.nix
  ];

  # Set the default status of all settings files
  config.${namespace}.homelab.settings = with lib; {
      localization.enable = mkDefault true;
      flatpak.enable = mkDefault false;
  };

  config = {
    
    # Enable flakes
    nix.settings.experimental-features = ["nix-command" "flakes"];
    nix.settings.cores = 0;

    # Set a hostId, this is needed by zfs
    networking.hostId = (builtins.substring 0 8 (builtins.hashString "sha256" config.networking.hostName));

    # Add time servers...
    networking.timeServers = [ "time.google.com" "time.cloudflare.com" ];
  };
}

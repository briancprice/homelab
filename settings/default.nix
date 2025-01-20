# nixos.nix - Nixos settings
{ config, pkgs, lib, namespace, ... }:
{
  imports = [
    ./localization.nix
    ./flatpak.nix
  ];
 

  # Use username as group name
  # TODO: Fix solitary by default
  # users.solitaryByDefault = true;

  config = {
    # Enable flakes
    nix.settings.experimental-features = ["nix-command" "flakes"];
    nix.settings.cores = 0;

    # Set a hostId, this is needed by zfs
    networking.hostId = (builtins.substring 0 8 (builtins.hashString "sha256" config.networking.hostName));
  };
}
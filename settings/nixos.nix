# nixos.nix - Nisos settings
{ config, pkgs, ... }:
{
  # Enable flakes
  nix.settings.experimental-features = ["nix-command" "flakes"];
  nix.settings.cores = 0;
}
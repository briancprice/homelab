# wired.nix
{ config, pkgs, ... }:
{
  # Enable networking
  networking.networkmanager.enable = true;
}

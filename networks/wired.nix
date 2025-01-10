# wired.nix
{ config, pkgs, lib, ... }:
with lib; {
  networking.networkmanager.enable = true;

  # Disable ipv6
  networking.enableIPv6 = mkDefault false;
  services.bind.ipv4Only = mkDefault true;

}

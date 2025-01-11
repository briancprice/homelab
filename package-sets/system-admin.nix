# admin.nix
# System packages useful for system administration
{ config, pkgs, ... }:
{
  environment.systemPackages = with pkgs; [
    vim git wget usbutils pciutils nfs-utils
  ];
}
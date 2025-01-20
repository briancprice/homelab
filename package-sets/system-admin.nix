# admin.nix
# System packages useful for system administration
{ config, pkgs, ... }:
{
  environment.systemPackages = with pkgs; [
    neofetch
    vim git 
    wget 
    usbutils pciutils nfs-utils 
    lm_sensors smartmontools
  ];
}

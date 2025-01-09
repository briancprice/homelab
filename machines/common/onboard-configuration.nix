# default.nix
# Provides a simple nix-os installation intended for bootstrapping the real install
{ config, lib, pkgs, ... }:
let
   
in
{
  # Warning: if impermenance is setup, make sure to preserve the machine-id
  imports = [
    # Set up the network host-id
    ../../networks/network-host-id.nix
  ];


  # Set up preliminary ssh
  services.openssh.enable = true;
  services.openssh.settings.PermitRootLogin = "prohibit-password";
  
  # Setup the root user used for onboarding
  users.mutableUsers = false;
  users.users.root.openssh.authorizedKeys.keys = [ "ssh-ed25519 AAAAC3NzaC1lZDI1NTE5AAAAIKQM3PinzEcWHWb7JZ+5iJMttHhlbIizZ4T9bcXvCD3f" ];
  users.users.root.initialHashedPassword = "$y$j9T$ey8R7Bclqq3pWW477qgU//$xtVBLgFR5KsmRdM4pLfITdRnp2TdBDZ6I5T7Z4fnuE.";
  
  # Default Packages
  environment.systemPackages = with pkgs; [
    vim git wget usbutils pciutils
  ];

  system.stateVersion = "24.11"; # Did you read the comment?
}

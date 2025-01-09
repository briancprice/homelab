# default.nix
# Provides a simple nix-os installation intended for bootstrapping the real install
{ config, lib, pkgs, ... }:
let
   
in
{
  # Set up preliminary ssh
  services.openssh.enable = true;
  services.openssh.settings.PermitRootLogin = "prohibit-password";
  users.users.root.openssh.authorizedKeys.keys = [ "ssh-ed25519 AAAAC3NzaC1lZDI1NTE5AAAAIKQM3PinzEcWHWb7JZ+5iJMttHhlbIizZ4T9bcXvCD3f" ];

  # Default Packages
  environment.systemPackages = with pkgs; [
    vim git wget usbutils pciutils
  ];

  system.stateVersion = "24.11"; # Did you read the comment?
}

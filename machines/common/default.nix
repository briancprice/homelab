# default.nix
# Provides a simple nix-os installation intended for bootstrapping the real install
{ config, lib, pkgs, ... }:
let
  oldPostInstallScript = boot.installer.postInstallation; 
in
{
  imorts = 
  [
    ./boot-efi.nix
    ./common.nix
  ];

  # Set up preliminary ssh
  services.openssh.enable = true;
  services.openssh.settings.permitRootLogin = "prohibit-password";
  users.users.root.openssh.authorizedKeys = [ "ssh-ed25519 AAAAC3NzaC1lZDI1NTE5AAAAIKQM3PinzEcWHWb7JZ+5iJMttHhlbIizZ4T9bcXvCD3f" ];
  boot.installer.postInstallation = 
  '' 
    ${oldPostInstallScript}\n
    echo "WARNING: Root login is enabled for SSH"
  '';

  # Default Packages
  environment.systemPackages = with pkgs; [
    vim git wget usbutils pciutils
  ];

  system.stateVersion = "24.11"; # Did you read the comment?
}

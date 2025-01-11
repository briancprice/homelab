# openssh-permissive.nix
# This is the default permissive ssh config
{ config, ... }:
{
  # Enable the OpenSSH daemon.
  services.openssh.enable = true;
  services.openssh.settings.PermitRootLogin = "prohibit-password";

  # Password authentication is disabled 
  services.openssh.settings.PasswordAuthentication = false;

  # Configure the root openssh command
  # TODO: move to sops
  users.users.root.openssh.authorizedKeys.keys = [ "ssh-ed25519 AAAAC3NzaC1lZDI1NTE5AAAAIKQM3PinzEcWHWb7JZ+5iJMttHhlbIizZ4T9bcXvCD3f" ];

}
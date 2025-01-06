# openssh-permissive.nix
# This is the default permissive ssh config
{ config, ... }:
{
  # Enable the OpenSSH daemon.
  services.openssh.enable = true;
  # We still disable root login
  services.openssh.settings.PermitRootLogin = "no";
  # Password authentication is enabled
  services.openssh.settings.PasswordAuthentication = true;


}
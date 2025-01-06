# system-minimal.nix
# These system packages should be installed even in a minimal system
{ config, pkgs, ... }:
{
  environment.systemPackages = with pkgs; [
     vim # Do not forget to add an editor to edit configuration.nix! The Nano editor is also installed by default.
     wget
     git

     bitwarden-cli
  ];
}
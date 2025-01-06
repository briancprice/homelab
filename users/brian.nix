# brian.nix
# The nixos users.users.brian settings
{ config, pkgs, ... }:
{
  # Define a user account. Don't forget to set a password with ‘passwd’.
  users.users.brian = {
    isNormalUser = true;
    description = "brian";
    extraGroups = [ "networkmanager" "wheel" ];
    packages = with pkgs; [
      tldr
    ];
  };a
}
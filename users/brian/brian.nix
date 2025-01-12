# brian.nix
# The nixos users.users.brian settings
{ config, pkgs, ... }:
let name = "brian"; in
{
  # Define a user account. Don't forget to set a password with ‘passwd’.
  users.users.${name} = {
    isNormalUser = true;
    description = "brian";
    group = name;
    extraGroups = [ "networkmanager" "wheel" ];
    packages = with pkgs; [
      tldr
    ];
  };
  users.groups.${name} = {};
}
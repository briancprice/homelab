# beth.nix
# The nixos users.users.beth settings
{ config, pkgs, ... }:
{
  # Define a user account. Don't forget to set a password with ‘passwd’.
  users.users = {
    isNormalUser = true;
    description = "beth";
    extraGroups = [ "networkmanager" ];
    packages = with pkgs; [
      tldr
    ];
  };a
}


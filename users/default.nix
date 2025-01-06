# /users/default.nix
# Loads the configuration for all the nixos users
{ config, pkgs, ... }:
{
  imports = [
    ./brian.nix
    ./beth.nix
  ];

  # Disable root login
  users.users.root.hashedPassword = null;
}

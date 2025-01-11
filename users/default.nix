# /users/default.nix
# Loads the configuration for all the nixos users
{ config, pkgs, ... }:
{
  imports = [
    ./brian.nix
    ./beth.nix
    ./root.nix
  ];
}

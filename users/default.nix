# /users/default.nix
# Loads the configuration for all the nixos users
{ config, pkgs, ... }:
{
  imports = [
    ./brian/brian.nix
    ./beth/beth.nix
    ./root/root.nix
  ];
}

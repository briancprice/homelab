# /users/default.nix
# Loads the configuration for all the nixos users
{ config, pkgs, lib, inputs, ... }:
{
  imports = [
    ./brian/brian.nix
    ./beth/beth.nix
    ./root/root.nix
  ];

    home-manager.useUserPackages = true;
    home-manager.useGlobalPkgs = true;
    home-manager.users.brian = import ./brian/brian-home-de.nix;
}

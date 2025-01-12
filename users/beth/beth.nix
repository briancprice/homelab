# beth.nix
# The nixos users.users.beth settings
{ config, pkgs, ... }:
let name = "beth"; in
{
  users.users.${name} = {
    isNormalUser = true;
    description = "Beth";
    group = name;
    extraGroups = [ "networkmanager" ];
    packages = with pkgs; [
      tldr
    ];
  };
  users.groups.${name} = {};
}
{ config, lib, namespace, ... }: 
with lib; {
  imports = [
    ./cinnamon.nix
  ];

  config.${namespace}.homelab.desktops.cinnamon.enable = mkDefault false;
}
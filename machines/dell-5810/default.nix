# Default configuration for my Dell 5810
{ config, lib, namespace, ... }:
let
  cfg = config.${namespace}.homelab-machines.dell-5810;
in
with lib; {
  imports = [
    ./hardware-configuration-with-filesystem.nix
    ./virtualization.nix
    ./graphics-nvidia-k4000.nix
  ];

  # Enable/Disable sub-configs
  config = {
    virtualization.enabled = mkDefault true;
    graphics.k4000.enabled = mkDefault false;
  }
}
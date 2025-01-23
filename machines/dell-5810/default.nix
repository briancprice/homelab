# Default configuration for my Dell 5810
{ config, lib, namespace, ... }:
let
  cfg = config.${namespace}.homelab-machines.dell-5810;
in
with lib; {
  imports = [
    ./hardware-configuration-with-filesystems.nix
    ./virtualization.nix
    ../common/nvidia.nix
  ];

  # Enable/Disable sub-configs
  config.${namespace}.homelab-machines.dell-5810 = {
    virtualization.enable = mkDefault true;
    # cfg.graphics.k4000.enable = mkDefault false;

    # Define our graphics cards...
    graphics.nvidia.cards = {
      nvidia-1060 = {
        deviceId = "10de:1c03";
        graphics-pcieId = "04:00.0";
        sound-pcieId = "04:00.1";
        iommu-group = 47;
      };

      nvidia-k4000 = {
        deviceId = "10de:11fa";
        graphics-pcieId = "03:00.0";
        sound-pcieId = "03:00.1";
        iommu-group = 46;
      };
    };



  };

}
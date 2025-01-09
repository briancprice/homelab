# machine-configuration.nix
# Lenovo machine configurations settings
# Requires 
# - disko
{ config, inputs, ... }:
{
  config.networking.hostName = "lenovo";  
    imports = [
      # Use disko to mount the disks
      inputs.disko.nixosModules.disko
      ./disko.nix

      # Use the default boot settings
      ../common/boot-efi.nix

      # Hardware configuration for lenovo laptop
      ../qemu-guest/hardware-configuration.nix
      ];
}


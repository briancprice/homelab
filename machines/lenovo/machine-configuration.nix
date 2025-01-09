# machine-configuration.nix
# Lenovo machine configurations settings
# Requires 
# - disko
{ config, inputs, ... }:
{
  config.networking.hostName = "lenovo";  
    config._module.args.zfs_arc_max = 4;
    imports = [
      # Use disko to mount the disks
      inputs.disko.nixosModules.disko
      ./disko.nix

      # Use the default boot settings
      ../common/boot-efi.nix

      # Default zfs settings
      ../common/zfs.nix

      # Hardware configuration for lenovo laptop
      ../qemu-guest/hardware-configuration.nix
      ];
}


# machine-configuration.nix
# Lenovo machine configurations settings
# Requires 
# - disko
{ config, inputs, ... }:
{
  # The host name
  # Note, the host name is also used to calculate the machine name
  config.networking.hostName = "lenovo";  

  # ZFS settings...
  config.services.zfs.trim.enable = true;
  # config.boot.kernelParams = ["zfs.zfs_arc_max=${builtins.toString(1024 * 1024 * 1024 * 4)}"];
  # The following line is required for vms
  config.boot.zfs.devNodes = "/dev/disk/by-path";

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


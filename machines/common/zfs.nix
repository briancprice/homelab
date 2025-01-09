# zfs.config
# Default configuration settings
# zfs_arc_max is in GB
{ config, zfs_arc_max ? 4, ... }:
{
   # ZFS Configuration
  boot.kernelParams = ["zfs.zfs_arc_max=${builtins.toString(1024 * 1024 * 1024 * zfs_arc_max)}"];
  boot.zfs.devNodes = "/dev/disk/by-path";
  services.zfs.trim.enable = true;
}

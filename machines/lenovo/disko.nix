 # Disko configuration for my lenovo laptop
{
  disko.devices = 
  {
    disk.main = {
      device = "/dev/vda";
      type = "disk";
      content = {
        type = "gpt";
        partitions = {

          # The Boot Partition
          ESP = {
            size = "500M";
            type = "EF00";
            content = 
            {
              type = "filesystem";
              format = "vfat";
              mountpoint = "/boot";
              mountOptions = ["umask=0077"];
            };
          };

          # The Data Partition 
          zdevone = {
            size = "100%";
            content = 
            {
              type = "zfs";
              pool = "premium";
            };
          };
       };
      };
    
    };

    # Ephemeral root partition
    memdisk."/" = {
      fsType = "tmpfs";
      mountOptions = [ "noatime" "norelatime" "size=25%" "mode=755" ];
    };

    # Initialize zfs
    zpool.premium = {
      type = "zpool";
      mode = "";

      # options are lowercase -o settings
      options = {
        ashift = "12";
        autotrim = "on"
      };

      # rootFsOptions are uppercase -O settings
      rootFsOptions = {
        acltpe = "posixacl";
        atime = "off";
        relatime = "off";
        compression = "lz4";
        dnodesize = "auto";
        mountpoint = "none";
        recordsize = "128KB";
        xattr = "sa";
      };

      # Initialize zfs datases
      zpool.premium.datasets = {
        reserved = {
          type = "zfs_fs";
          options.mountpoint = "none";
          options.refreservation = "10G";
        };

        persist = {
          type = "zfs_fs";
          mountpoint = "/"
        }

        # The NixOS persistant settings will be here
        nix = {
          type = "zfs_fs";
          mountpoint = "/nix";
        }
      }

    };
  };
}

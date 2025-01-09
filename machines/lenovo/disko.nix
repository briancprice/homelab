 # Disko configuration for my lenovo laptop
{
  disko.devices = 
  {
    disk.main = 
    {
      device = "/dev/vda";
      type = "disk";
      content = 
      {
        type = "gpt";
        partitions = {

          # The Boot Partition
          ESP = 
          {
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

          # The Root partition "/"
          /*
          root =
          {
            label = "root";
            type = "tmpfs";
            options = "size=4G";
            mountpoint = "/";
          };
          */
          
          root = 
          {
            size = "100%";
            content = 
            {
              type = "filesystem";
              format = "ext4";
              mountpoint = "/";
              mountOptions = [ "noatime" "norelatime" ];
            };
          };
        };
      };
    };
  };
}

{ config, device ... }:
let
  espPartition = import ./disko-partition-ESP.nix {};
in 
{
  {
    device = device;
    type = "disk";
    content = {
      type = "gpt";
        partitions = {
          ESP = espPartition;
          root = {
            SIZE = "95%";
            content = {
              type = "filesystem";
              format = "ext4";
              mountpoint = "/";
              mountOptions = [ "noatime, norelatime" ];
            };
          };
        };
      };
  };
}  

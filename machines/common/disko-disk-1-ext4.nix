{ config, device, ... }:
let
  espPartition = import ./disko-partition-ESP.nix { inherit config; device = "vda"; };
in 
{
  device = device;
  type = "disk";
  content = {
    type = "gpt";
      partitions = {
        ESP = espPartition;
        root = {
          size = "95%";
          content = {
            type = "filesystem";
            format = "ext4";
            mountpoint = "/";
            mountOptions = [ "noatime, norelatime" ];
          };
        };
      };
    };
}  

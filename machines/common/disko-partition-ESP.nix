# disko-partition-ESP.nix
{ config, ... }:
{
  size = "500M";
  type = "EF00";
  content = {
    type = "filesystem";
    format = "vfat";
    mountpoint = "/boot";
    mountOptions = ["unmask=0077"];
  };
}

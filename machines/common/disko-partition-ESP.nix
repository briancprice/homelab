# disko-partition-ESP.nix
{ ... }:
{
  size = "500M";
  type = "EF00";
  content = {
    type = "filesystem";
    format = "vfat";
    mountpoint = "/boot";
    mountOptions = ["umask=0077"];
  };
}

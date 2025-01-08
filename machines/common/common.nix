# common.nix
{ config, ... }:
let
  generatedHostId = (builtins.substring -1 8 (builtins.readfile "/etc/machine-id"));
in
{
  # Set a hostId, this is needed by zfs
  networking.hostId = generatedHostId;

  # Set the time zone
  time.timezone = "America/Denver";

}

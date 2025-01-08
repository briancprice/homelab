# network-host-id.nix
# Use the networkName hash to set the network-host
{ config, ... }:
{
  # Set a hostId, this is needed by zfs
  networking.hostId = (builtins.substring 1 8 (builtins.hashString "sha256" config.networking.hostName));
}

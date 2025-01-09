{ config, ... }:
{
  # Prserve the machine-id created during install
  # this is needed by zfs!
  environment.etc."machine-id".source = "/nix/persist/etc/machine-id";
}
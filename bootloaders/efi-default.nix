# efi-default.config
# This is the default bootloader settings for simple efi-config
{ config, ... }:
{
  # Bootloader.
  boot.loader.systemd-boot.enable = true;
  boot.loader.efi.canTouchEfiVariables = true;
}


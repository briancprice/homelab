# The default option schemas for the homelab project are defined here.
# Other module-specific options may defined elsewhere, but these
# Are globally available
{ config, ... }:
{
  imports = [
    ./homelab.nix
    ./constants.nix
  ];
}
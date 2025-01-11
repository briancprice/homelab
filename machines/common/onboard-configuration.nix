# default.nix
# Provides a simple nix-os installation intended for bootstrapping the real install
{ config, lib, pkgs, ... }:
let
   
in
{
  # Warning: if impermenance is setup, make sure to preserve the machine-id
  imports = [
    # Settings 
    ../../settings
    # Users
    ../../users/root.nix
    # Package sets
    ../../package-sets/system-admin.nix
    ../../package-sets/system-minimal.nix
    # Services
    ../../services/openssh/openssh-permissive.nix
  ]; 
}

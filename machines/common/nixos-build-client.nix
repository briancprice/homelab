# nixos-build-client.nix
# Configuration file to map to a central nfs share of the nixos config
{ ... }:
{
  
  fileSystems."/etc/nixos" = {
    # TODO: Read nfs build server from config
    device = "192.168.50.128:/etc/nixos"
    fsType = "nfs";
    options = [ "ro" "soft" "init" ];
    needeForBoot = false;
  };
}
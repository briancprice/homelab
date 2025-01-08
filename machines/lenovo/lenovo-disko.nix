 # Disko configuration for my lenovo laptop
{
  disko.devices = {
    disk.main = import ../common/disko-disk-1-ext4.nix { device = "/dev/vda"; };
  };
}

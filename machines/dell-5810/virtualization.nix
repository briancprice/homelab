# Enable virtualization for the Dell 5810 server
{ config, namespace, ... }: with lib;
let
  cfg = config.${namespace}.homelab-machines.dell-5810.virtualization;
{
  options.${namespace}.homelab-machines.dell-5810.virtualization = {
    enable = mkEnable {
      default = false;
      description = ''Enable virtualization support on this dell-5810'';
    };
  };

  config = mkIf cfg.enable {
    boot.kernelParams = ["intel_iommu=on"];
  };
}

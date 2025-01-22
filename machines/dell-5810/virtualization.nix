# Enable virtualization for the Dell 5810 server
{ config, lib, namespace, ... }:
let
  cfg = config.${namespace}.homelab-machines.dell-5810.virtualization;
in with lib; {
  options.${namespace}.homelab-machines.dell-5810.virtualization = {
    enable = mkEnableOption {
      default = false;
      description = ''Enable virtualization support on this dell-5810'';
    };
  };

  config = mkIf cfg.enable {

    # Enable IOMMU
    boot.kernelParams = ["intel_iommu=on"];
  };
}

{ config, pkgs, lib, namespace, ... }:
let
  cfg = config.${namespace}.homelab.services.virtualisation;
in
with lib; {
  options.${namespace}.homelab.services.virtualisation = {
    enable = mkEnableOption {
      default = false;
      description = "Enable libvirt support.";
    };

    enableVirtualMachineManager = mkEnableOption {
      default = false;
      description = "Enable Virtual Machine Manager UI";
    };
  };

  config = mkIf cfg.enable {
    
    virtualisation.libvirtd.enable = true;
    programs.virt-manager.enable = cfg.enableVirtualMachineManager;

    # TODO: Create systemd script to define the storage pools
  };
}
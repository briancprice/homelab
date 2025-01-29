{ config, lib, namespace, ... }: with lib; 
let
  cfg = config.${namespace}.homelab;
  dellCfg = config.${namespace}.homelab.machines.dell-5810;
  dell-graphics = config.${namespace}.homelab.machines-custom.dell-5810.graphics;
in
{

  imports = [
    ({ config, namespace, ... }: let cfg = config.${namespace}.homelab; in {
      
      config.${namespace}.homelab = {
        machines.dell-5810 = {
          virtualisation.enable = true;
        };

        machines-custom.dell-5810 = {
          graphics = {
            isolate1060 = true;
            isolateK4000 = false;
            hostNvidiaGraphicsDriver = "proprietary";
            headlessHost = false;
          };
        };

        headless = false;

        settings.networking = {
          enable = true;
          primaryNetworkInterface = dellCfg.primaryNetworkInterface;
          defaultNetworkingConfig = "static-bridge";
          primaryNetworkBridge = "br0";
          disableIPV6 = true;
        };

        settings.flatpak = {
          enable = true;
        };

        services.openssh = {
          enable = true;
          mode = "secure";
          opensshUserName = "brian";
        };

        services.virtualisation = {
          enable = true;
          enableVirtualMachineManager = true;
        };

        desktops.cinnamon.enable = true;
      };
    })
  ];

  
  config.networking.hostName = "nixos-dev";
  config.networking.interfaces.${cfg.settings.networking.primaryNetworkBridge} = {
    ipv4.addresses = [
      {
        address = "192.168.50.10";
        prefixLength = 24;
      }];
  };
  

  config.networking.defaultGateway = "192.168.50.1";
  config.networking.nameservers = [ "192.168.50.1" ];

}
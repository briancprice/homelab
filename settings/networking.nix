# settings/networking.nix
# TODO: Determine best way to disable network-manager if needed.
{ config, lib, namespace, ... }:
let
  cfg = config.${namespace}.homelab.settings.networking;
in 
with lib; {

  options.${namespace}.homelab.settings.networking = {
    enable = mkEnableOption {
      default = false;
    };

    defaultNetworkingConfig = mkOption {
      type = types.enum [ "disabled" "dhcp" "dhcp-wireless" "static" "static-bridge" ];
      default = "dhcp";
      description = 
        ''
        **disabled**:       Do not configure default network options.
        **dhcp**:           Use DHCP on the primary network interface.
        **dhcp-wireless"    Use DHCP with network manager and enable wireless.
        **static**:         Configure a static interface, you must configure the IP, Gateway, and DNS.
        **static-bridge**:  Configure a bridge on the primary interface, you must configure the IP, Gateway, and DNS.
        '';
    };

    primaryNetworkInterface = mkOption {
      type = types.nullOr types.str;
      default = null;
      example = "enp0s25";
      description = "The primary network interface used to configure this network.";
    };

    disableIPV6 = mkOption {
      type = types.bool;
      default = true;
      description = "Disable IPV6 Networking.";
    };

    primaryNetworkBridge = mkOption {
      type = types.nullOr types.str;
      example = "br0";
      default = null;
      description = "The primary network bridge name.  This will default to br0 if defaultNetworkingConfig option is set to true, otherwise, you have to set it.";
    };
  };

  config = mkIf cfg.enable {

    # Disable IPV6
    services.bind.ipv4Only = mkIf cfg.disableIPV6 mkDefault true;

    networking = if cfg.defaultNetworkingConfig == "dhcp" then {
      
      # DHCP Network on primary nic
      useDHCP = mkDefault true;
      networkmanager.enable = true;
      enableIPv6 = mkIf cfg.disableIPV6 false;

    } else if cfg.defaultNetworkingConfig == "dhcp-wireless" then {
    
      # DHCP Network on wireless nic
      # wireless.enable = true;
      networkmanager.enable = true;
      useDHCP = mkDefault true;
      enableIPv6 = mkIf cfg.disableIPV6 false;
    
    } else if cfg.defaultNetworkingConfig == "static" then
      assert lib.asserts.assertMsg (builtins.isString cfg.primaryNetworkInterface) 
        "primaryNetworkInterface must be set to configure static IPs";
    {

      # Static Network on primary nic
      useDHCP = false;
      # networkmanager.enable = mkDefault false;
      enableIPv6 = mkIf cfg.disableIPV6 false;
    
    } else if cfg.defaultNetworkingConfig == "static-bridge" then
      assert assertMsg (builtins.isString cfg.primaryNetworkInterface)
        "primaryNetworkInterface must be set to configure the bridge.";
      assert assertMsg (builtins.isString cfg.primaryNetworkBridge)
        "The primaryNetworkBridge must be set.";
    {
      # Static Network on primary bridge, usually br0
      # networkmanager.enable = mkDefault false;
      useDHCP = mkForce false;
      enableIPv6 = mkIf cfg.disableIPV6 false;


      bridges.${cfg.primaryNetworkBridge} = {
          interfaces = [ cfg.primaryNetworkInterface ];
      };
      
      interfaces.${cfg.primaryNetworkBridge} = {
        useDHCP = false;
      };

    } else {};
  };
}
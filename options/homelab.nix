# Global homelab settings
{ config, pkgs, lib, namespace, ... }: with lib; {

  options.${namespace}.homelab.desktop.enabled = mkEnableOption {
    default = false;
    description = "Enable desktop UIs on this host.";
    example = true;
  };

  config = {};
  
}
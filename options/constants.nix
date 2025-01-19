# Define a constants dictionary for use in our nixos configuration
{ config, pkgs, lib, namespace, ... }: with lib; {
  
  options.${namespace}.homelab.constants = mkOption {
    type = types.attrsOf types.str;
    description = "Constant values for the homelab confiuration";
  };

  config = {};
}
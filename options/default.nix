# The default option schemas for the homelab project are defined here.
# Other module-specific options may defined elsewhere, but these
# Are globally available
{ config, lib, namespace, ... }:
{
   options.${namespace}.homelab = {
    headless = lib.mkOption {
      type = lib.types.bool;
      default = true;
      description = "Indicates whether the system is running without a desktop.";
    };

    constants = lib.mkOption {
      type = lib.types.attrsOf lib.types.str;
      description = "Constant values for the homelab configuration";
    };
   };

  config = {};
}
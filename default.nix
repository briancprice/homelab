{config, pkgs, lib, namespace, ... }: 
let
  cfg = config.options.${namespace}.homelab;
in
with lib; {
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

    /*
    adminUserName = lib.mkOption {
      type = lib.string;
      description = "The name of the admin user account for this machine";
      default = "brian";
    };

    includeUsers = lib.mkOption {
      type = lib.types.listOf string;
      description = "List of user accounts to include in this installation.";
      default = [ cfg.adminUserName ];
    };
    */
  };

  imports = [
    ./settings
    #./services
    ./desktops
    ./users
  ];
}
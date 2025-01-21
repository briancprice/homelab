# The NVIDIA k4000 config
{ config, pkgs, lib, namespace, ... }: with lib;
let 
  cfg = config.${namespace}.homelab-machines.dell-5810.graphics.k4000;

  # Note, these values are specific to the installation on my Dell 5810 PC.
  _deviceId = "10de:11fa";
  _graphics-pcieId = "03:00.0";
  _sound-pcieId = "03:00.1";
  
{
  options.${namespace}.homelab-machines.dell-5810.graphics.k4000 = {
    enable = mkEnable { 
    default = true; 
    description = ''
      The enable option enables the cards settings, if enable is set to false, the card will be handled using the 
      default OS settings, typically it will be assigned to the nouveau driver.
      ''
    };

    driver = mkOption {
      type = types.enum [ "nouveau" "legacy_390" "vfio-pci" ];
      default = "nouveau";
      description = ''
      The driver to use for the NVIDIA K4000 graphics card
      * **nouveau:**    (default), The open-source Nouveau driver.  Not to be confused with the NVIDIA open-source driver.
      * **legacy_390:** The legacy NVIDIA 390 proprietary driver, this is the latest driver that supports the k4000
      * **vfio-pci:**   Use VFIO to pass the card through to virtual machines
      '';
    };

    deviceId = mkOption {
      type = types.string;
      default = _deviceId;
      description = ''The device ID'';
    };

    pcieId = mkOption {
      type = types.string;
      default = _graphics-pcieId;
      description = ''The PCIE ID of the card, in the format 03:00.0'';
    };

  };

  # k4000 configuration options
  config = mkIf cfg.enable {

    hardware.nvidia = {

      # Set the legacy driver if configured
      package = mkIf (cfg.driver == "legacy_390") boot.kernelPackages.nvidiaPackages.legacy_390;
      # Blacklist the nouveau driver
      boot.blacklistedKernelModules = mkIf (cfg.driver == "legacy_390") [ "nouveau" ];
    
    
      # The NVIDIA open-source driver doesn't support the k4000
      # Disable it here and if another card needs it, override elsewhere 
      open = mkDefault false;
      warnings = if open then [
        ''You have enabled the NVIDIA opens source driver.
          This driver does not support the k4000!
        ''] else [];
    };

  };
}
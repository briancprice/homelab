{ config, lib, namespace, ... }: with lib; 
{ 
  options.${namespace}.homelab.settings.localization.enabled = mkEnableOption { default = true; };

  config = mkIf config.${namespace}.homelab.settings.localization.enabled {
    # Set your time zone.
    time.timeZone = "America/Denver";

    # Select internationalization properties.
    i18n.defaultLocale = "en_US.UTF-8";

    i18n.extraLocaleSettings = {
      LC_ADDRESS = "en_US.UTF-8";
      LC_IDENTIFICATION = "en_US.UTF-8";
      LC_MEASUREMENT = "en_US.UTF-8";
      LC_MONETARY = "en_US.UTF-8";
      LC_NAME = "en_US.UTF-8";
      LC_NUMERIC = "en_US.UTF-8";
      LC_PAPER = "en_US.UTF-8";
      LC_TELEPHONE = "en_US.UTF-8";
      LC_TIME = "en_US.UTF-8";
    }; 

    # Configure keymap in X11
    services.xserver.xkb = mkIf config.${namespace}.homelab.headless {
      layout = "us";
      variant = "";
    };
  };
}


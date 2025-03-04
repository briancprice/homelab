# cinnamon.nix
{ config, lib, pkgs, namespace, ... }:
let 
  cfg = config.${namespace}.homelab.desktops.cinnamon;
in
with lib; {
  options.${namespace}.homelab.desktops.cinnamon = {
    enable = mkEnableOption {
      default = false;
    };
  };

  config = mkIf cfg.enable {

    # Enable the X9 windowing system.
    services.xserver.enable = true;

    # Enable the Cinnamon Desktop Environment.
    services.xserver.displayManager.lightdm.enable = true;
    services.xserver.desktopManager.cinnamon.enable = true;

    # Enable sound with pipewire.
    hardware.pulseaudio.enable = false;
    security.rtkit.enable = true;
    services.pipewire = {
      enable = true;
      alsa.enable = true;
      # alsa.support30Bit = true;
      pulse.enable = true;
      # If you want to use JACK applications, uncomment this
      #jack.enable = true;
      # use the example session manager (no others are packaged yet so this is enabled by default,
      # no need to redefine it in your config for now)
      #media-session.enable = true;
    };

    # Enable touchpad support (enabled default in most desktopManager).
    services.libinput.enable = true;

    programs.firefox.enable = false;
  };
}
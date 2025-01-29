# Installs flatpak support, 
#   - Adds the gnome-software store
#   - Adds the flathub repository
# TODO: Add the flatpak declarative management support.
{ config, pkgs, lib, namespace, ... }:
let
  cfg = config.${namespace}.homelab.settings.flatpak;
  in
with lib; {
  options.${namespace}.homelab.settings.flatpak = {
    enable = mkEnableOption {
      description = "Enable flatpak, if this install is not headless, the gnome-software package will also be installed.";
      default = false;
    };
  };
  

  config = mkIf cfg.enable {
    # Enable flatpak
    services.flatpak.enable = true;

    # Add the gnome-software store
    environment.systemPackages = mkIf (!cfg.headless) [
      pkgs.gnome-software
    ];

    # Add the flathub repo
    systemd.services.add-flatpak-repos = {
      wantedBy = [ "multi-user.target" ];
      path = [ pkgs.flatpak ];
      script = ''
        flatpak remote-add --if-not-exists flathub https://dl.flathub.org/repo/flathub.flatpakrepo
      '';
    };
  };
}

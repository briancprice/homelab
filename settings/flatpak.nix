# Installs flatpak support, 
#   - Adds the gnome-software store
#   - Adds the flathub repository
{ config, pkgs, lib, namespace, ... }:
{
  options.${namespace}.homelab.settings.flatpak.enable = lib.mkEnableOption { default = false; };
  

  config = lib.mkIf config.${namespace}.homelab.settings.flatpak.enable {
    # Enable flatpak
    services.flatpak.enable = true;

    # Add the gnome-software store
    environment.systemPackages = with pkgs; [
      gnome-software
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

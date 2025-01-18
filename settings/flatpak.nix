# Installs flatpak support, 
#   - Adds the gnome-software store
#   - Adds the flathub repository
{ config, pkgs, ... }:
{
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

}


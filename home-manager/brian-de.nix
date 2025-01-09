# brian-de.nix
# Brian's home-manager settings for machines with a desktop environment
{ config, pkgs, ... }:
{
  # Setup my wallpaper
  # TODO: Disable if not gnome
  home.file.wallpaper = {
    source = ../desktops/wallpaper;
    target = ".config/cinnamon/backgrounds";
    recursive = true;
  };
  dconf.settings."org/cinnamon/desktop/background" = {
    picture-uri = "file://${config.home.homeDirectory}/.config/cinnamon/backgrounds/gray_orange_mountain_1.jpeg";
  };
  
  programs.chromium.enable = true;
  programs.vscode = {
    enable = true;
     extensions = with pkgs.vscode-extensions; [
       jnoortheen.nix-ide
       vscodevim.vim
     ];

     userSettings = {
       "editor.tabSize" = 2;
       "editor.stickyScroll.enabled" = false;
     };
  };
}
  

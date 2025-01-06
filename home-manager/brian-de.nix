# brian-de.nix
{ config, pkgs, ... }:
{
  meta.description = "Brian's home-manager settings for machines with a desktop environment";
  
  programs.chromium.enable = true;
  programs.vscode = {
    enable = true;
     extensions = with pkgs.vscode-extensions; [
       jnoortheen.nix-ide
       vscodevim.vim
     ];

     userSettings = {
       "editor.tabSize" = 2;
     };
  };
}
  

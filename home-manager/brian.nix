
# "Brian's default home-manager configuration";
{ config, pkgs, ... }:
{
  home.username = "brian";
  home.homeDirectory = "/home/brian";
  home.stateVersion = "24.11";

  imports = [
    ./brian-de.nix
  ];

  home.sessionVariables = {
    SUDO_EDITOR = "vim";
    EDITOR = "vim";
  };

  programs.git = {
    enable = true;
    userEmail = "1766482+briancprice@users.noreply.github.com";
    userName = "Brian Price";
  };

  programs.neovim = {
    enable = true;
    plugins = with pkgs.vimPlugins; [
      nvim-treesitter
      nvim-lspconfig
      vim-nix
    ];

    extraConfig = ''
                  '';
    };

  programs.zsh.enable = true;

}
  

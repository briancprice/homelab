
# "Brian's default home-manager configuration";
{ config, pkgs, osConfig, ... }:
{
  home.username = "brian";
  home.homeDirectory = "/home/brian";
  home.stateVersion = osConfig.system.stateVersion;

  imports = [
  ];

  home.sessionVariables = {
    SUDO_EDITOR = "vim";
    EDITOR = "vim";
    NIX_PATH = "~/homelab";
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
  

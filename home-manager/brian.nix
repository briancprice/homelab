{ config, pkgs, ... }:
{
  meta.description = "Brian's default home-manager configuration"
  home.username = "brian";
  home.homeDirectory = "/home/brian";
  home.stateVersion = "24.11";

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
                  -- Add config here
                  '';
    };

  programs.zsh.enable = true;

}
  

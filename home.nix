{ config, pkgs, ... }:
{
  home.username = "brian";
  home.homeDirectory = "/home/brian";
  home.stateVersion = "24.11";

  home.sessionVariables = {
    SUDO_EDITOR = "vim";
    EDITOR = "vim";
  };

  programs.chromium.enable = true;

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

  programs.zsh.enable = true;

}
  

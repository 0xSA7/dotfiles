{ config, pkgs, unstablePkgs, ... }:

{
  
  imports = [
    ./kitty.nix
    ./neovim.nix
    ./tmux.nix
    ./zsh.nix
  ];

 
  home.packages = with pkgs; [
    kitty
    git
    fzf
    ripgrep
    imagemagick
    ueberzugpp   
  ];

  programs.home-manager.enable = true;
}

{ config, pkgs, unstablePkgs,lib, ... }:

{
  
  imports = [
    ./kitty.nix
    ./neovim.nix
    ./tmux.nix
    ./zsh.nix
  ];

# home.activation.linkGnomeExtensions = lib.hm.dag.entryAfter [ "writeBoundary" ] ''
#    $DRY_RUN_CMD mkdir -p $VERBOSE_ARG "$HOME/.local/share/gnome-shell"
#    $DRY_RUN_CMD ln -sfn $VERBOSE_ARG "$HOME/.nix-profile/share/gnome-shell/extensions" "$HOME/.local/share/gnome-shell/extensions"
#  '';
 
  home.packages = with pkgs; [
    git
    fzf
    ripgrep
    imagemagick
    ueberzugpp   
  ];

  programs.home-manager.enable = true;
}

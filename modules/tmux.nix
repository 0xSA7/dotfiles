{ config, pkgs, ... }:

{
  programs.tmux = {
    enable = true;
    clock24 = true;
    mouse = true;
    baseIndex = 1;
    shortcut = "a"; 
    terminal = "tmux-256color";
    
    plugins = with pkgs.tmuxPlugins; [
      catppuccin
      sensible
      yank
    ];

    extraConfig = ''
      # Split panes using | and -
      bind | split-window -h
      bind - split-window -v
      unbind '"'
      unbind %

      # Enable vi keys in copy mode
      setw -g mode-keys vi
      
      # Status bar position
      set-option -g status-position top
    '';
  };
}

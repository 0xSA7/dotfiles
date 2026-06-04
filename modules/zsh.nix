{ config, pkgs, ... }:

{
  # Zsh Configuration
  programs.zsh = {
    enable = true;
    autocd = true;
    enableCompletion = true;
    autosuggestion.enable = true;
    syntaxHighlighting.enable = true;
    
    initContent = ''
	export PATH="$HOME/.local/bin:$HOME/bin:$PATH"
    	zstyle ':completion:*' menu select 
      
    	bindkey "^[[1;5D" backward-word
    	bindkey "^[[1;5C" forward-word
    '';

    shellAliases = {
      # Replace standard commands with alternatives
      ls = "eza --icons";
      ll = "eza -lh --icons";
      la = "eza -lah --icons";
#      cat = "bat";
            
      # NixOS shortcuts
      update = "cd ~/dotfiles && nix flake update && sudo nixos-rebuild switch --flake .#raad";
      apply = "cd ~/dotfiles && sudo nixos-rebuild switch --flake .#raad";
      cleanup = "sudo nix-collect-garbage -d";
      
      # System monitoring
      top = "btop";

     # Switching kitty theme
     light = "~/dotfiles/scripts/theme-switch.sh light";
     dark = "~/dotfiles/scripts/theme-switch.sh dark";
    };
  };

  # Modern ls alternative
  programs.eza = {
    enable = true;
    enableZshIntegration = true;
  };

  # Modern cat alternative
  programs.bat = {
    enable = true;
  };

  # Fuzzy finder
  programs.fzf = {
    enable = true;
    enableZshIntegration = true;
  };

  # Smart cd alternative
  programs.zoxide = {
    enable = true;
    enableZshIntegration = true;
  };

  # Starship Prompt
programs.starship = {
    enable = true;
    enableZshIntegration = true;
    settings = {
      format = "[╭─](bold blue) $directory$git_branch$git_status\n[╰─](bold blue)$character";
      directory = {
        style = "bold cyan";
        read_only = " ";
        format = "[$path]($style) ";
      };
      git_branch = {
        symbol = " ";
        format = "[$symbol$branch](bold purple) ";
      };
      git_status = {
        format = "[$all_status$ahead_behind](bold red) ";
      };
      character = {
        success_symbol = "[❯](bold green)";
        error_symbol = "[❯](bold red)";
      };
    };
  }; 
}

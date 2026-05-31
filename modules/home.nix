{ config, pkgs, ... }:

{

  imports = [
     ./gnome.nix
  ];

  home.username = "sa7";
  home.homeDirectory = "/home/sa7";
  
  home.stateVersion = "25.11"; 

  # ==========================================
  # PERSONAL PACKAGES
  # ==========================================
  home.packages = with pkgs; [
    # --- Desktop & GUI Apps ---
    discord vlc vscode gnome-tweaks kitty copyq brave telegram-desktop steam-run wl-clipboard   

    # --- Android & Mobile ---
    #android-studio scrcpy android-tools apktool jadx apksigner flutter

    # --- Networking & Pentesting ---
    tcpdump nmap netcat socat mitmproxy openssl httptoolkit burpsuite httpie

    # --- Reverse Engineering ---
    ghidra radare2 binwalk patchelf strace ltrace

    # --- Development & CLI Tools ---
    gemini-cli cargo rustc rustfmt rust-analyzer python3 python3Packages.pip python3Packages.virtualenv sqlite docker-compose tmux neovim jq ripgrep fd btop fastfetch duf dust
  ];

  # ==========================================
  # PROGRAM CONFIGURATIONS
  # ==========================================
  
  # Git Configuration
  programs.git = {
    enable = true;
    settings = {
      user = {
        name = "0xSA7";
        email = "REDACTED@local.host";
      };
      init.defaultBranch = "main";
      core.editor = "nano";
      pull.rebase = true;
    };
  };

  # Kitty Terminal Configuration
  programs.kitty = {
    enable = true;
    themeFile = "Catppuccin-Mocha"; 
    font = {
      name = "FiraCode Nerd Font";
      size = 12;
    };
    settings = {
      background_opacity = "0.90";
      window_padding_width = 10;
      confirm_os_window_close = 0;
      enable_audio_bell = false;
    };
  };

  # Zsh Configuration
  programs.zsh = {
    enable = true;
    autocd = true;
    enableCompletion = true;
    autosuggestion.enable = true;
    syntaxHighlighting.enable = true;
    
    initContent = ''
    	zstyle ':completion:*' menu select 
      
    	bindkey "^[[1;5D" backward-word
    	bindkey "^[[1;5C" forward-word
    '';

    shellAliases = {
      # Replace standard commands with modern alternatives
      ls = "eza --icons";
      ll = "eza -lh --icons";
      la = "eza -lah --icons";
      cat = "bat";
            
      # NixOS shortcuts
      update = "cd ~/dotfiles && nix flake update && sudo nixos-rebuild switch --flake .#raad";
      apply = "cd ~/dotfiles && sudo nixos-rebuild switch --flake .#raad";
      cleanup = "sudo nix-collect-garbage -d";
      
      # System monitoring
      top = "btop";
    };
  };

  # Starship Prompt
  programs.starship = {
    enable = true;
    enableZshIntegration = true;
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

  # ==========================================
  # ENVIRONMENT VARIABLES
  # ==========================================
  home.sessionPath = [
    "$HOME/bin"
  ];
  
  home.sessionVariables = {
    ANDROID_HOME = "/home/sa7/Android/Sdk";
    ANDROID_SDK_ROOT = "/home/sa7/Android/Sdk";
  };


  # Let Home Manager install and manage itself
  programs.home-manager.enable = true;
}

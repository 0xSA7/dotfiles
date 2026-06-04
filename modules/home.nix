{ config, pkgs, ... }:

{

  imports = [
     ./gnome.nix
     ./kitty.nix
     ./zsh.nix
     ./tmux.nix
     ./neovim.nix
  ];

  home.username = "sa7";
  home.homeDirectory = "/home/sa7";
  
  home.stateVersion = "25.11"; 

  # ==========================================
  # PERSONAL PACKAGES
  # ==========================================
  home.packages = with pkgs; [
    # --- Desktop & GUI Apps ---
    discord vlc vscode gnome-tweaks kitty copyq brave telegram-desktop steam-run wl-clipboard adwaita-icon-theme shared-mime-info  

    # --- Android & Mobile ---
    #android-studio scrcpy android-tools apktool jadx apksigner flutter

    # --- Networking & Pentesting ---
    tcpdump nmap netcat socat mitmproxy openssl httptoolkit burpsuite httpie

    # --- Reverse Engineering ---
    ghidra radare2 binwalk patchelf strace ltrace

    # --- Development & CLI Tools ---
    gemini-cli cargo rustc rustfmt rust-analyzer python3 python3Packages.pip python3Packages.virtualenv sqlite docker-compose jq ripgrep fd btop fastfetch duf dust
  ];

    # ==========================================
  # PROGRAM CONFIGURATIONS
  # ==========================================
  
  # Git Configuration
  programs.git = {
    enable = true;
    userName = "0xSA7";
    includes = [
      { path = "~/.gitconfig.local"; }
    ];
    extraConfig = {
      init.defaultBranch = "main";
      core.editor = "nano";
      pull.rebase = true;
    };
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

  # ==========================================
  # CURSOR THEME (Bibata Ice)
  # ==========================================
  home.pointerCursor = {
    name = "Bibata-Modern-Ice";
    package = pkgs.bibata-cursors;
    size = 24;
    gtk.enable = true;
    x11.enable = true;
  };

  # Let Home Manager install and manage itself
  programs.home-manager.enable = true;
}

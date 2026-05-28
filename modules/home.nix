{ config, pkgs, ... }:

{
  home.username = "sa7";
  home.homeDirectory = "/home/sa7";
  
  home.stateVersion = "25.11"; 

  # ==========================================
  # PERSONAL PACKAGES
  # ==========================================
  home.packages = with pkgs; [
    # --- Desktop & GUI Apps ---
    discord vlc vscode gnome-tweaks kitty copyq brave telegram-desktop steam-run    

    # --- Android & Mobile ---
    #android-studio scrcpy android-tools apktool jadx apksigner flutter

    # --- Networking & Pentesting ---
    tcpdump nmap netcat socat mitmproxy openssl httptoolkit burpsuite httpie

    # --- Reverse Engineering ---
    ghidra radare2 binwalk patchelf strace ltrace

    # --- Development & CLI Tools ---
    cargo rustc rustfmt rust-analyzer python3 python3Packages.pip python3Packages.virtualenv sqlite docker-compose tmux neovim jq ripgrep fd
  ];

  # ==========================================
  # ENVIRONMENT VARIABLES
  # ==========================================
  home.sessionVariables = {
    ANDROID_HOME = "/home/sa7/Android/Sdk";
    ANDROID_SDK_ROOT = "/home/sa7/Android/Sdk";
  };

  # Let Home Manager install and manage itself
  programs.home-manager.enable = true;
}

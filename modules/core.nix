{ config, pkgs, ... }:

{
  # ==========================================
  # NIX OS SETTINGS & GC
  # ==========================================
  nix.settings.experimental-features = [ "nix-command" "flakes" ]; 
  nix.settings.auto-optimise-store = true;
  nix.gc = {
    automatic = true;
    dates = "weekly";
    options = "--delete-older-than 7d";
  };
  nixpkgs.config.allowUnfree = true;
  nixpkgs.config.android_sdk.accept_license = true;

  # ==========================================
  # NETWORKING (Shared)
  # ==========================================
  networking.networkmanager.enable = true;
  networking.firewall = {
    enable = true;
    allowedTCPPorts = [ 8080 ];
  };

  # ==========================================
  # TIME & LOCALIZATION
  # ==========================================
  time.timeZone = "Africa/Cairo";
  i18n.defaultLocale = "en_US.UTF-8";
  i18n.extraLocaleSettings = {
    LC_ADDRESS = "ar_EG.UTF-8";
    LC_IDENTIFICATION = "ar_EG.UTF-8";
    LC_MEASUREMENT = "ar_EG.UTF-8";
    LC_MONETARY = "ar_EG.UTF-8";
    LC_NAME = "ar_EG.UTF-8";
    LC_NUMERIC = "ar_EG.UTF-8";
    LC_PAPER = "ar_EG.UTF-8";
    LC_TELEPHONE = "ar_EG.UTF-8";
    LC_TIME = "ar_EG.UTF-8";
  };

  # ==========================================
  # DESKTOP ENVIRONMENT & X11 (GNOME)
  # ==========================================
  hardware.graphics.enable = true;
  services.xserver = {
    enable = true;
    xkb = {
      layout = "us,ara";
      variant = ",";
      options = "grp:alt_shift_toggle";
    };
  };

  services.displayManager.gdm.enable = true;
  services.desktopManager.gnome.enable = true;

  # ==========================================
  # AUDIO (PIPEWIRE) & BLUETOOTH
  # ==========================================
  hardware.bluetooth = {
    enable = true;
    powerOnBoot = true;
  };

  services.pulseaudio.enable = false;
  security.rtkit.enable = true;
  services.pipewire = {
    enable = true;
    alsa.enable = true;
    alsa.support32Bit = true;
    pulse.enable = true;
  };

  # ==========================================
  # USER ACCOUNT (SA7)
  # ==========================================
  users.users.sa7 = {
    isNormalUser = true;
    description = "0xSA7";
    extraGroups = [ "networkmanager" "wheel" "docker" "wireshark" "adbusers" ];
    shell = pkgs.zsh;
    packages = with pkgs; [];
  };

  # ==========================================
  # SERVICES, VIRTUALIZATION & DEV TOOLS
  # ==========================================
  services.fstrim.enable = true;
  services.printing.enable = true;
  virtualisation.docker.enable = true;
  
  programs.zsh.enable = true;
  programs.firefox.enable = true;
  programs.wireshark.enable = true;
  programs.nix-ld.enable = true;
  programs.java.enable = true;
  programs.java.package = pkgs.jdk17;


  # ==========================================
  # GAMING & STEAM
  # ==========================================
  programs.steam = {
    enable = true;
    remotePlay.openFirewall = true; 
    dedicatedServer.openFirewall = true;
    gamescopeSession.enable = true;
  };
  
  hardware.graphics.enable32Bit = true;

  # ==========================================
  # SYSTEM PACKAGES & FONTS
  # ==========================================
  environment.systemPackages = with pkgs; [
    git wget curl unzip zip gnupg file which tree htop
    libva libva-utils vulkan-tools pciutils psmisc
    gcc gnumake cmake gdb pkg-config android-tools
  ];

  fonts.packages = with pkgs; [
    nerd-fonts.fira-code
    nerd-fonts.jetbrains-mono
  ];

  # ==========================================
  # SYSTEM STATE VERSION
  # ==========================================
  system.stateVersion = "25.11"; 
}

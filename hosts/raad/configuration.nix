{ config, pkgs, ... }:

{
  imports = [ 
    ./hardware-configuration.nix 
  ];

  # ==========================================
  # 1. BOOTLOADER & KERNEL
  # ==========================================
  boot.loader.systemd-boot.enable = false;
  boot.loader.grub = {
    enable = true;
    device = "nodev";
    efiSupport = true;
    useOSProber = true;
  };
  boot.loader.efi.canTouchEfiVariables = true;
  boot.loader.efi.efiSysMountPoint = "/boot"; 

  boot.kernelParams = [
    "nvidia-drm.modeset=1"
    "nvidia.NVreg_PreserveVideoMemoryAllocations=1"
    "nvidia.NVreg_TemporaryFilePath=/var/temp"
    "nvme_core.default_ps_max_latency_us=0"
    "pcie_aspm=off"
  ];

  # ==========================================
  # 2. NIX OS SETTINGS & GC
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
  # 3. NETWORKING & FIREWALL
  # ==========================================
  networking.hostName = "raad";
  networking.networkmanager.enable = true;
  networking.firewall = {
    enable = true;
    allowedTCPPorts = [ 8080 ];
  };

  # ==========================================
  # 4. TIME & LOCALIZATION
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
  # 5. GRAPHICS, X11 & DESKTOP (GNOME)
  # ==========================================
  hardware.graphics.enable = true;
  services.xserver = {
    enable = true;
    videoDrivers = ["nvidia"];
    xkb = {
      layout = "us,ara";
      variant = ",";
      options = "grp:alt_shift_toggle";
    };
  };

  services.displayManager.gdm.enable = true;
  services.desktopManager.gnome.enable = true;

  hardware.nvidia = {
    prime = {
      sync.enable = true;
      intelBusId = "PCI:0:2:0";  
      nvidiaBusId = "PCI:1:0:0";
    };
    modesetting.enable = true;
    powerManagement.enable = true;
    open = false;
    nvidiaSettings = true;
  };

  # ==========================================
  # 6. AUDIO (PIPEWIRE) & BLUETOOTH
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
  # 7. USER ACCOUNT (SA7)
  # ==========================================
  users.users.sa7 = {
    isNormalUser = true;
    description = "0xSA7";
    extraGroups = [ "networkmanager" "wheel" "docker" "wireshark" "adbusers" ];
    packages = with pkgs; [];
  };

  # ==========================================
  # 8. SERVICES, VIRTUALIZATION & DEV TOOLS
  # ==========================================
  services.fstrim.enable = true;
  services.printing.enable = true;
  virtualisation.docker.enable = true;
  
  programs.firefox.enable = true;
  programs.wireshark.enable = true;
  programs.adb.enable = true;
  programs.nix-ld.enable = true;
  programs.java.enable = true;
  programs.java.package = pkgs.jdk17;

  # ==========================================
  # 9. SYSTEM PACKAGES & FONTS
  # ==========================================
  environment.systemPackages = with pkgs; [
    git vim wget curl unzip zip gnupg file which tree htop
    libva libva-utils vulkan-tools mesa-demos pciutils 
    gcc gnumake cmake gdb pkg-config
  ];

  fonts.packages = with pkgs; [
    nerd-fonts.fira-code
    nerd-fonts.jetbrains-mono
  ];

  # ==========================================
  # 10. SYSTEM STATE VERSION (DO NOT CHANGE)
  # ==========================================
  system.stateVersion = "25.11"; 
}

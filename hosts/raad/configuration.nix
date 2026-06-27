{ config, pkgs, lib, ... }:

{
  imports = [ 
    ./hardware-configuration.nix 
    ../../modules/core.nix 
    ../../modules/virtualization.nix
  ];

  # ==========================================
  # HOSTNAME
  # ==========================================
  networking.hostName = "raad";
  programs.dconf.enable = true;

  # ==========================================
  # BOOTLOADER (Lanzaboote / Secure Boot)
  # ==========================================
  boot.loader.grub.enable = lib.mkForce false;
  boot.loader.systemd-boot.enable = lib.mkForce false;

  boot.lanzaboote = {
    enable = true;
    pkiBundle = "/etc/secureboot";
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
  # NVIDIA CONFIGURATION
  # ==========================================
  services.xserver.videoDrivers = ["nvidia"];

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
  # System-wide dynamic linker
  # ==========================================
  programs.nix-ld.enable = true;
  programs.nix-ld.libraries = with pkgs; [
    stdenv.cc.cc.lib
    zlib
    glib
  ];
}

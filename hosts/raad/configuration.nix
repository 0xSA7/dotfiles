{ config, pkgs, ... }:

{
  imports = [ 
    ./hardware-configuration.nix 
    ../../modules/core.nix 
  ];

  # ==========================================
  # HOSTNAME
  # ==========================================
  networking.hostName = "raad";
# System-level configuration
programs.dconf.enable = true;
  # ==========================================
  # BOOTLOADER (GRUB)
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
}

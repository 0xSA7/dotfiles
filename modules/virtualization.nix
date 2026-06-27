{ config, pkgs, ... }:

{
  # Enable virt-manager
  programs.virt-manager.enable = true;

  # Core virtualization configuration
  virtualisation.libvirtd = {
    enable = true;
    qemu = {
      package = pkgs.qemu_kvm;
      runAsRoot = true;
      swtpm.enable = true;
      # CRITICAL: This exposes virtiofsd to the QEMU environment on NixOS
      vhostUserPackages = [ pkgs.virtiofsd ];
    };
  };

  # Required management, protocol, and networking packages
  environment.systemPackages = with pkgs; [
    virt-viewer
    spice
    spice-gtk
    spice-protocol
    virtio-win
    win-spice
    bridge-utils
    vde2
    dnsmasq
    virtiofsd
  ];

  # User access permissions
  users.users.sa7.extraGroups = [ "libvirtd" "kvm" ];

  # ==========================================
  # VFIO & IOMMU Configuration for PCI Passthrough
  # ==========================================
  boot.kernelModules = [ "vfio" "vfio_iommu_type1" "vfio_pci" "vfio_virqfd" ];
  boot.kernelParams = [ "intel_iommu=on" "iommu=pt" ];

}

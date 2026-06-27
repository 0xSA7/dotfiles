{ config, pkgs, ... }:

{
  programs.hyprland = {
    enable = true;
    xwayland.enable = true;
  };

  environment.systemPackages = with pkgs; [
    waybar
    rofi-wayland
    swaybg
    wl-clipboard
    dunst
    hyprpaper
  ];
}

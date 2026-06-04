{ config, pkgs, ... }:

{
  programs.kitty = {
    enable = true;
    themeFile = "kanagawa"; # Default starting theme
    font = {
      name = "JetBrainsMono Nerd Font";
      size = 12;
    };
    settings = {
      background_opacity = "0.90";
      window_padding_width = 10;
      confirm_os_window_close = 0;
      enable_audio_bell = false;
      allow_remote_control = "yes";
      listen_on = "unix:@kitty-{kitty-pid}";
    };
  };
}

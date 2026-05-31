{ config, pkgs, ... }:

{
  # ==========================================
  # GNOME PACKAGES & EXTENSIONS
  # ==========================================
  home.packages = with pkgs; [
    gnome-tweaks
    gnomeExtensions.appindicator
    gnomeExtensions.dash-to-dock
    gnomeExtensions.blur-my-shell
    gnomeExtensions.caffeine
    gnomeExtensions.clipboard-indicator
    gnomeExtensions.gsconnect
    gnomeExtensions.vitals
    gnomeExtensions.unblank
  ];

  # ==========================================
  # GNOME DESKTOP SETTINGS (DCONF)
  # ==========================================
  dconf.settings = {
    # Custom Keybindings (Kitty)
    "org/gnome/settings-daemon/plugins/media-keys" = {
      custom-keybindings = [ "/org/gnome/settings-daemon/plugins/media-keys/custom-keybindings/custom0/" ];
    };
    "org/gnome/settings-daemon/plugins/media-keys/custom-keybindings/custom0" = {
      binding = "<Control><Alt>t";
      command = "kitty";
      name = "Open Terminal (Kitty)";
    };

    # Desktop Interface (Dark Mode & Clock)
    "org/gnome/desktop/interface" = {
      color-scheme = "prefer-dark";
      enable-hot-corners = false;
      clock-show-weekday = true;
    };

    # Window Manager (Buttons)
    "org/gnome/desktop/wm/preferences" = {
      button-layout = "appmenu:minimize,maximize,close";
    };

    # Touchpad (Tap to click)
    "org/gnome/desktop/peripherals/touchpad" = {
      tap-to-click = true;
    };

    # GNOME Extensions Enablement
    "org/gnome/shell" = {
      disable-user-extensions = false;
      enabled-extensions = [
        "appindicatorsupport@rgcjonas.gmail.com"
        "dash-to-dock@micxgx.gmail.com"
        "blur-my-shell@aunetx"
        "caffeine@patapon.info"
        "clipboard-indicator@tudmotu.com"
        "gsconnect@andyholmes.github.io"
        "Vitals@CoreCoding.com"
        "unblank@sun.wxg@gmail.com"
        "in-picture@filiprund.cz"
      ];
    };
 
    # Dash to Dock Specific Settings
    "org/gnome/shell/extensions/dash-to-dock" = {
      dock-position = "BOTTOM";
      dash-max-icon-size = 48;
      transparency-mode = "DYNAMIC";
    };
  };
}

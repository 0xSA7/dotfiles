{ config, pkgs, ... }:

{
  # ==========================================
  # GNOME PACKAGES & EXTENSIONS
  # ==========================================
  home.packages = with pkgs; [
    inter
    bibata-cursors
    gnome-tweaks
    gnomeExtensions.vertical-workspaces
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

    # Dash to Dock Specific Settings
    "org/gnome/shell/extensions/dash-to-dock" = {
      dock-position = "BOTTOM";
      dash-max-icon-size = 48;
      transparency-mode = "DYNAMIC";
    };

    # Window Manager (Buttons)
    "org/gnome/desktop/wm/preferences" = {
      button-layout = "appmenu:minimize,maximize,close";
    };

    # Fonts & Interface (Inter for UI, JetBrains Mono for Monospace)
    "org/gnome/desktop/interface" = {
      color-scheme = "prefer-dark";
      enable-hot-corners = false;
      clock-show-weekday = true;
      font-name = "Inter 11";
      document-font-name = "Inter 11";
      monospace-font-name = "JetBrainsMono Nerd Font 11";
    };

    # Minimal Sounds (Disable UI pop/click sounds)
    "org/gnome/desktop/sound" = {
      # event-sounds = false;
    };

    # Touchpad (Tap to click)
    "org/gnome/desktop/peripherals/touchpad" = {
      tap-to-click = true;
    };

    # Clipboard Indicator (Super+V Shortcut)
    "org/gnome/shell/extensions/clipboard-indicator" = {
      history-size = 50;
      clear-on-boot = true;
      move-item-first = true;
      toggle-menu = [ "<Super>v" ]; 
    };

   # Power & Sleep Behavior
    "org/gnome/desktop/session" = {
      idle-delay = 300; 
    };
    "org/gnome/desktop/screensaver" = {
      lock-enabled = true;
      lock-delay = 0; 
    };
    "org/gnome/settings-daemon/plugins/power" = {
      sleep-inactive-ac-type = "suspend";
      sleep-inactive-ac-timeout = 480; 
      sleep-inactive-battery-type = "suspend";
      sleep-inactive-battery-timeout = 480;
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
	"vertical-workspaces@G-dH.github.com"
      ];
    };
 
  };
}

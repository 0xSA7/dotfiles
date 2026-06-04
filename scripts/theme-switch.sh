#!/usr/bin/env bash

# ==============================================================
# System-Wide Theme & Smart Random Wallpaper Switcher
# Architecture: Declarative-friendly external state manager
# Supported DE/WM: GNOME, Hyprland
# ==============================================================

MODE=$1
WALLPAPER_DIR="$HOME/dotfiles/wallpapers"
CACHE_DIR="$HOME/.cache/theme-switcher"
CACHE_FILE="$CACHE_DIR/last_wp_$MODE"

# Validate input
if [ -z "$MODE" ]; then
  echo "Error: No mode specified. Usage: $0 {light|dark}"
  exit 1
fi

# Ensure cache directory exists
mkdir -p "$CACHE_DIR"

# --------------------------------------------------------------
# 0. Smart Random Wallpaper Selection (Pure Bash & No-Repeat)
# --------------------------------------------------------------
TARGET_DIR="$WALLPAPER_DIR/$MODE"

if [ -d "$TARGET_DIR" ]; then
  # Load files into pure bash array with depth limit
  mapfile -t wallpapers < <(find "$TARGET_DIR" -maxdepth 1 -type f)
  WP_COUNT=${#wallpapers[@]}
  
  if [ "$WP_COUNT" -eq 0 ]; then
    echo "Warning: No wallpapers found in $TARGET_DIR"
    WP_URI=""
  elif [ "$WP_COUNT" -eq 1 ]; then
    # Only one wallpaper exists, just use it
    RANDOM_WP="${wallpapers[0]}"
    WP_URI="file://$RANDOM_WP"
  else
    # Multiple wallpapers: read cache and pick a non-repeating one
    LAST_WP=$(cat "$CACHE_FILE" 2>/dev/null)
    
    while true; do
      RANDOM_WP="${wallpapers[RANDOM % WP_COUNT]}"
      if [ "$RANDOM_WP" != "$LAST_WP" ]; then
        break
      fi
    done
    
    # Save current selection to cache
    echo "$RANDOM_WP" > "$CACHE_FILE"
    WP_URI="file://$RANDOM_WP"
  fi
else
  echo "Error: Directory $TARGET_DIR does not exist."
  exit 1
fi

# --------------------------------------------------------------
# 1. Desktop Environment & Wallpaper Sync
# --------------------------------------------------------------
if [ "$MODE" = "light" ]; then
  if [ "$XDG_CURRENT_DESKTOP" = "GNOME" ]; then
    gsettings set org.gnome.desktop.interface color-scheme 'default'
    [ -n "$WP_URI" ] && gsettings set org.gnome.desktop.background picture-uri "$WP_URI"
  elif [ "$XDG_CURRENT_DESKTOP" = "Hyprland" ]; then
    # TODO: Add swaybg or hyprpaper dynamic logic here
    echo "Hyprland Light Mode Triggered. WP: $RANDOM_WP"
  fi
elif [ "$MODE" = "dark" ]; then
  if [ "$XDG_CURRENT_DESKTOP" = "GNOME" ]; then
    gsettings set org.gnome.desktop.interface color-scheme 'prefer-dark'
    [ -n "$WP_URI" ] && gsettings set org.gnome.desktop.background picture-uri-dark "$WP_URI"
  elif [ "$XDG_CURRENT_DESKTOP" = "Hyprland" ]; then
    # TODO: Add swaybg or hyprpaper dynamic logic here
    echo "Hyprland Dark Mode Triggered. WP: $RANDOM_WP"
  fi
fi

# --------------------------------------------------------------
# 2. Kitty Terminal Sync
# --------------------------------------------------------------
if [ "$MODE" = "light" ]; then
  kitty +kitten themes --dump-theme Kanagawa_light > /tmp/k_theme.conf
elif [ "$MODE" = "dark" ]; then
  kitty +kitten themes --dump-theme Kanagawa > /tmp/k_theme.conf
fi

kitty @ set-colors -a /tmp/k_theme.conf

# --------------------------------------------------------------
# 3. Neovim Sync (RPC Broadcast)
# --------------------------------------------------------------
for server in "${XDG_RUNTIME_DIR:-/run/user/$(id -u)}"/nvim.*; do
  if [ -S "$server" ]; then
    if [ "$MODE" = "light" ]; then
      nvim --server "$server" --remote-send '<C-\><C-n>:colorscheme kanagawa-lotus<CR>' &>/dev/null
    elif [ "$MODE" = "dark" ]; then
      nvim --server "$server" --remote-send '<C-\><C-n>:colorscheme kanagawa-wave<CR>' &>/dev/null
    fi
  fi
done

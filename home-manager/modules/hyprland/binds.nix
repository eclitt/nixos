{ pkgs, ... }:
let
  changeWallpaperScript = pkgs.writeShellScriptBin "change-wallpaper" ''
    #!/bin/bash

    WALLPAPER_DIR="$HOME/Pictures/Wallpapers/normal"

    if [ ! -d "$WALLPAPER_DIR" ]; then
        echo "Ошибка: Директория с обоями не найдена: $WALLPAPER_DIR" >&2
        exit 1
    fi

    # Выбираем случайный файл
    WALLPAPER=$(find "$WALLPAPER_DIR" -type f \( -name "*.jpg" -o -name "*.png" -o -name "*.webp" \) | shuf -n 1)

    if [ -z "$WALLPAPER" ]; then
        echo "Ошибка: В директории не найдено подходящих изображений." >&2
        exit 1
    fi

    # Предзагружаем изображение
    ${pkgs.hyprland}/bin/hyprctl hyprpaper preload "$WALLPAPER"

    # Устанавливаем обои через hyprctl с разными режимами
    # Для горизонтального монитора (режим cover)
    ${pkgs.hyprland}/bin/hyprctl hyprpaper wallpaper " ,$WALLPAPER"
    
    # Для вертикального монитора (режим contain) :cite[1]:cite[4]
    ${pkgs.hyprpaper}/bin/hyprctl hyprpaper wallpaper "HDMI-A-1,contain:$WALLPAPER"

    # Опционально: выгружаем неиспользуемые обои для экономии памяти (через небольшой период)
    sleep 1 
    ${pkgs.hyprland}/bin/hyprctl hyprpaper unload unused
  '';
in
{
  home.packages = [ changeWallpaperScript ];
  wayland.windowManager.hyprland.settings = {
    bind = [
      # Launch Terminal
      "$mainMod,       Return, exec, $terminal"
      # Launch Firefox
      "$mainMod,       B, exec, firefox"
      # Launch Filemanager
      "$mainMod,       E, exec, $fileManager"
      "$mainMod SHIFT, E, exec, kitty ranger"
      # Launch Telegramm
      "$mainMod,       T, exec, AyuGram"
      # Launch Program menu
      "$mainMod,       Space, exec,pkill $menu || $menu --show drun"
      # Lock System
      "$mainMod,       L, exec, hyprlock"
      "$mainMod SHIFT, L, exit"
      # Screenshot
      "$mainMod SHIFT, S, exec, hyprshot -m region --clipboard-only"
      "$mainMod SHIFT CONTROL, S, exec, hyprshot -m region"
      # Fullscreen
      "$mainMod,       F, fullscreen, 0"
      "$mainMod SHIFT, F, fullscreen, 1"
      
      # Wallpaper script
      #"$mainMod,       Z, exec, ${changeWallpaperScript}/bin/change-wallpaper"
      
      # Cliphistory
      "$mainMod,       V, exec, cliphist list | wofi -S dmenu | cliphist decode | wl-copy"

      # Standart hyprland Binds
      "$mainMod,       W, killactive,"
      "$mainMod,       N, togglefloating,"
      "$mainMod,       J, togglesplit,"
      "$mainMod,       P, pseudo,"

      # Moving focus
      "$mainMod, left, movefocus, l"
      "$mainMod, right, movefocus, r"
      "$mainMod, up, movefocus, u"
      "$mainMod, down, movefocus, d"

      # Moving windows
      "$mainMod SHIFT, left,  swapwindow, l"
      "$mainMod SHIFT, right, swapwindow, r"
      "$mainMod SHIFT, up,    swapwindow, u"
      "$mainMod SHIFT, down,  swapwindow, d"

      # Resizeing windows                   X  Y
      "$mainMod CTRL, left,  resizeactive, -60 0"
      "$mainMod CTRL, right, resizeactive,  60 0"
      "$mainMod CTRL, up,    resizeactive,  0 -60"
      "$mainMod CTRL, down,  resizeactive,  0  60"

      # Switching workspaces
      #"$mainMod, 1, workspace, 1"
      #"$mainMod, 2, workspace, 2"
      #"$mainMod, 3, workspace, 3"
      #"$mainMod, 4, workspace, 4"
      #"$mainMod, 5, workspace, 5"
      #"$mainMod, 6, workspace, 6"
      #"$mainMod, 7, workspace, 7"
      #"$mainMod, 8, workspace, 8"
      #"$mainMod, 9, workspace, 9"
      #"$mainMod, 0, workspace, 10"

      # Moving windows to workspaces
      #"$mainMod SHIFT, 1, movetoworkspacesilent, 1"
      #"$mainMod SHIFT, 2, movetoworkspacesilent, 2"
      #"$mainMod SHIFT, 3, movetoworkspacesilent, 3"
      #"$mainMod SHIFT, 4, movetoworkspacesilent, 4"
      #"$mainMod SHIFT, 5, movetoworkspacesilent, 5"
      #"$mainMod SHIFT, 6, movetoworkspacesilent, 6"
      #"$mainMod SHIFT, 7, movetoworkspacesilent, 7"
      #"$mainMod SHIFT, 8, movetoworkspacesilent, 8"
      #"$mainMod SHIFT, 9, movetoworkspacesilent, 9"
      #"$mainMod SHIFT, 0, movetoworkspacesilent, 10"

      # Magic workspace
      "$mainMod,       X, togglespecialworkspace,  magic"
      "$mainMod SHIFT, X, movetoworkspace, special:magic"
    ];

    # Move/resize windows with mainMod + LMB/RMB and dragging
    bindm = [
      "$mainMod, mouse:272, movewindow"
      "$mainMod, mouse:273, resizewindow"
    ];

    # Laptop multimedia keys for volume and LCD brightness
    bindel = [
      ",XF86AudioRaiseVolume,  exec, wpctl set-volume -l 1 @DEFAULT_AUDIO_SINK@ 5%+"
      ",XF86AudioLowerVolume,  exec, wpctl set-volume @DEFAULT_AUDIO_SINK@ 5%-"
      ",XF86AudioMute,         exec, wpctl set-mute @DEFAULT_AUDIO_SINK@ toggle"
      ",XF86AudioMicMute,      exec, wpctl set-mute @DEFAULT_AUDIO_SOURCE@ toggle"
      "$mainMod, bracketright, exec, brightnessctl s 10%+"
      "$mainMod, bracketleft,  exec, brightnessctl s 10%-"
    ];

    # Audio playback
    bindl = [
      ", XF86AudioNext,  exec, playerctl next"
      ", XF86AudioPause, exec, playerctl play-pause"
      ", XF86AudioPlay,  exec, playerctl play-pause"
      ", XF86AudioPrev,  exec, playerctl previous"
    ];
  };
}

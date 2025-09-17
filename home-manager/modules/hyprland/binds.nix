{ pkgs, ... }:
let
  wallpaperScript = pkgs.writeShellScriptBin "change-wallpaper" ''
    #!/bin/bash

    # Путь к папке с обоями
    WALLPAPER_DIR="$HOME/Pictures/Wallpapers/normal"

    # Проверяем, что папка существует
    if [ ! -d "$WALLPAPER_DIR" ]; then
        #notify-send "Ошибка" "Папка с обоями не найдена: $WALLPAPER_DIR"
        exit 1
    fi

    # Выбираем случайный файл (jpg/png/webp)
    WALLPAPER=$(find "$WALLPAPER_DIR" -type f \( -name "*.jpg" -o -name "*.png" -o -name "*.webp" \) | shuf -n 1)

    # Проверяем, что файл выбран
    if [ -z "$WALLPAPER" ]; then
        #notify-send "Ошибка" "В папке нет подходящих изображений"
        exit 1
    fi

    # Устанавливаем обои с анимацией
    ${pkgs.swww}/bin/swww img "$WALLPAPER" \
        --transition-type "any" \
        --transition-duration 1 \
        --transition-fps 60 \
        --transition-angle 30 \
        --transition-pos "top-right"

    # Уведомление о смене (опционально)
    #notify-send "Обои изменены" "$(basename "$WALLPAPER")" -i "$WALLPAPER"
  '';
in
{
  home.packages = [ wallpaperScript ];
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
      "$mainMod,       Z, exec, ${wallpaperScript}/bin/change-wallpaper"
      
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
      "$mainMod, 1, workspace, 1"
      "$mainMod, 2, workspace, 2"
      "$mainMod, 3, workspace, 3"
      "$mainMod, 4, workspace, 4"
      "$mainMod, 5, workspace, 5"
      "$mainMod, 6, workspace, 6"
      "$mainMod, 7, workspace, 7"
      "$mainMod, 8, workspace, 8"
      "$mainMod, 9, workspace, 9"
      "$mainMod, 0, workspace, 10"

      # Moving windows to workspaces
      "$mainMod SHIFT, 1, movetoworkspacesilent, 1"
      "$mainMod SHIFT, 2, movetoworkspacesilent, 2"
      "$mainMod SHIFT, 3, movetoworkspacesilent, 3"
      "$mainMod SHIFT, 4, movetoworkspacesilent, 4"
      "$mainMod SHIFT, 5, movetoworkspacesilent, 5"
      "$mainMod SHIFT, 6, movetoworkspacesilent, 6"
      "$mainMod SHIFT, 7, movetoworkspacesilent, 7"
      "$mainMod SHIFT, 8, movetoworkspacesilent, 8"
      "$mainMod SHIFT, 9, movetoworkspacesilent, 9"
      "$mainMod SHIFT, 0, movetoworkspacesilent, 10"

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

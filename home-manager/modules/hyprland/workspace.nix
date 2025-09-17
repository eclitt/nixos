{config, pkgs, ... }:
{
  wayland.windowManager.hyprland.settings = {
    # ПРИВЯЗКА РАБОЧИХ СТОЛОВ К МОНИТОРАМ
    workspace = [
      "1, monitor:DP-2, default:true"
      "2, monitor:DP-2"
      "3, monitor:DP-2"
      "4, monitor:DP-2"
      "5, monitor:DP-2"
      "6, monitor:DP-2"
      "7, monitor:HDMI-A-1"  # Терминал с утилитами
      "8, monitor:HDMI-A-1"
      "9, monitor:HDMI-A-1"
    ];
    
    # АВТОЗАПУСК ПРИЛОЖЕНИЙ НА WORKSPACE 7
    #exec-once = [
    #  "kitty --class matrix-terminal -e pipes.sh"  # Если pipes.sh - установленная программа
    #  "kitty --class clock-terminal -e peaclock"   # Если peaclock - установленная программа
    #];

    # ПРАВИЛА ОКОН ДЛЯ АВТОМАТИЧЕСКОГО РАЗМЕЩЕНИЯ
    windowrule = [
      "workspace 7, title:^matrix-terminal$"
      "workspace 7, title:^clock-terminal$"
      "float, title:^matrix-terminal$"
      "float, title:^clock-terminal$"
      "size 800 400, title:^matrix-terminal$"
      "size 400 300, title:^clock-terminal$"
      "move 100 100, title:^matrix-terminal$"
      "move 100 550, title:^clock-terminal$"
    ];
    
    bind = [
      "$mainMod, 1, workspace, 1"
      "$mainMod, 2, workspace, 2"
      "$mainMod, 3, workspace, 3"
      "$mainMod, 4, workspace, 4"
      "$mainMod, 5, workspace, 5"
      "$mainMod, 6, workspace, 6"
      "$mainMod CTRL, 1, workspace, 7"  # Исправлено: убрана запятая после C
      "$mainMod CTRL, 2, workspace, 8"
      "$mainMod CTRL, 3, workspace, 9"
      "$mainMod CTRL, 4, workspace, 10"

      "$mainMod SHIFT, 1, movetoworkspacesilent, 1"
      "$mainMod SHIFT, 2, movetoworkspacesilent, 2"
      "$mainMod SHIFT, 3, movetoworkspacesilent, 3"
      "$mainMod SHIFT, 4, movetoworkspacesilent, 4"
      "$mainMod SHIFT, 5, movetoworkspacesilent, 5"
      "$mainMod SHIFT, 6, movetoworkspacesilent, 6"
      "$mainMod SHIFT CTRL, 1, movetoworkspacesilent, 7"  # Исправлено: убрана запятая после C
      "$mainMod SHIFT CTRL, 2, movetoworkspacesilent, 8"
      "$mainMod SHIFT CTRL, 3, movetoworkspacesilent, 9"
      "$mainMod SHIFT CTRL, 4, movetoworkspacesilent, 10"
    ];
  };
}

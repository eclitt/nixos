{config, pkgs, ... }:
{
  wayland.windowManager.hyprland.settings = {
    # ПРИВЯЗКА РАБОЧИХ СТОЛОВ К МОНИТОРАМ
    workspace = [
      "1, , default:true"
   #   "2, monitor:DP-2"
   #   "3, monitor:DP-2"
   #   "4, monitor:DP-2"
   #   "5, monitor:DP-2"
   #   "6, monitor:DP-2"
   #   "7, monitor:HDMI-A-1"  # Терминал с утилитами
   #   "8, monitor:HDMI-A-1"
   #   "9, monitor:HDMI-A-1"
    ];
    
    # АВТОЗАПУСК ПРИЛОЖЕНИЙ НА WORKSPACE 7
   # exec-once = [
   #   "kitty --class matrix-terminal -e pipes.sh"  # Если pipes.sh - установленная программа
   #   "kitty --class clock-terminal -e peaclock"   # Если peaclock - установленная программа
   # ];

    # ПРАВИЛА ОКОН ДЛЯ АВТОМАТИЧЕСКОГО РАЗМЕЩЕНИЯ
   # windowrule = [
   #   "workspace 7, title:^matrix-terminal$"
   #   "workspace 7, title:^clock-terminal$"
   #   "float, title:^matrix-terminal$"
   #   "float, title:^clock-terminal$"
   #   "size 800 400, title:^matrix-terminal$"
   #   "size 400 300, title:^clock-terminal$"
   #   "move 100 100, title:^matrix-terminal$"
   #   "move 100 550, title:^clock-terminal$"
   # ];
    
    bind = [
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

      "$mainMod SHIFT, 1, movetoworkspacesilent, 1"
      "$mainMod SHIFT, 2, movetoworkspacesilent, 2"
      "$mainMod SHIFT, 3, movetoworkspacesilent, 3"
      "$mainMod SHIFT, 4, movetoworkspacesilent, 4"
      "$mainMod SHIFT, 5, movetoworkspacesilent, 5"
      "$mainMod SHIFT, 6, movetoworkspacesilent, 6"
      "$mainMod SHIFT, 7, movetoworkspacesilent, 7"
      "$mainMod SHIFT, 8, movetoworkspacesilent, 8"
      "$mainMod SHIFT, 9, movetoworkspacesilent, 9"
      "$mainMod SHIFT, 10, movetoworkspacesilent, 10"
    ];
  };
}

{config, pkgs, ... }:
{
  wayland.windowManager.hyprland.settings = {
    workspace = [
      "1, monitor:DP-2, default:true"
      "2, monitor:DP-2"
      "3, monitor:DP-2"
      "4, monitor:DP-2"
      "5, monitor:DP-2"
      "6, monitor:DP-2"
      "7, monitor:HDMI-A-1"
      "8, monitor:HDMI-A-1"
      "9, monitor:HDMI-A-1"
    ];
    bind = [
      "$mainMod, 1, workspace, 1"
      "$mainMod, 2, workspace, 2"
      "$mainMod, 3, workspace, 3"
      "$mainMod, 4, workspace, 4"
      "$mainMod, 5, workspace, 5"
      "$mainMod, 6, workspace, 6"
      "$mainMod CTRL, 1, workspace, 7"  
      "$mainMod CTRL, 2, workspace, 8"
      "$mainMod CTRL, 3, workspace, 9"
      "$mainMod CTRL, 4, workspace, 10"

      "$mainMod SHIFT, 1, movetoworkspacesilent, 1"
      "$mainMod SHIFT, 2, movetoworkspacesilent, 2"
      "$mainMod SHIFT, 3, movetoworkspacesilent, 3"
      "$mainMod SHIFT, 4, movetoworkspacesilent, 4"
      "$mainMod SHIFT, 5, movetoworkspacesilent, 5"
      "$mainMod SHIFT, 6, movetoworkspacesilent, 6"
      "$mainMod SHIFT CTRL, 1, movetoworkspacesilent, 7"
      "$mainMod SHIFT CTRL, 2, movetoworkspacesilent, 8"
      "$mainMod SHIFT CTRL, 3, movetoworkspacesilent, 9"
      "$mainMod SHIFT CTRL, 4, movetoworkspacesilent, 10"
    ];
  };
}

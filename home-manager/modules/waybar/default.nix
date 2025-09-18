{ config, lib, pkgs, ... }:
let
  cavaVisualizerScript = pkgs.writeShellScriptBin "waybar-cava" ''
    #!/bin/bash

    bar="▁▂▃▄▅▆▇█"
    dict="s/;//g;"

    # creating "dictionary" to replace char with bar
    i=0
    while [ $i -lt ${"$"}{#bar} ]
    do
        dict="''${dict}s/$i/''${bar:$i:1}/g;"
        i=$((i=i+1))
    done

    # write cava config
    config_file="/tmp/polybar_cava_config"
    echo "
    [general]
    bars = 18

    [output]
    method = raw
    raw_target = /dev/stdout
    data_format = ascii
    ascii_max_range = 7
    " > $config_file

    # read stdout from cava
    ${pkgs.cava}/bin/cava -p $config_file | while read -r line; do
        echo $line | sed "$dict"
    done
  '';
in
{
  home.packages = [ cavaVisualizerScript ];
  programs.waybar = {
    enable = true;
    style = ./style.css;
    settings = {
      mainBar = {
        layer = "top";
        position = "top";
        margin-bottom = 0;
        spacing = 0;

        # Modules
        modules-left = [
          "clock"
          "custom/cava"
          "group/hardware"
          "tray"
        ];

        modules-center = [
          "hyprland/workspaces"
        ];

        modules-right = [
          "hyprland/language"
          "network"
          "pulseaudio"
	  "battery"
          "group/group-power"
        ];

        # Left Modules
        clock = {
          tooltip = false;
          format = "{:%H:%M:%S  -  %A, %d}";
          interval = 1;
        };

        tray = {
          icon-size = 16;
          spacing = 5;
        };

        "custom/cava" = {
          format = "{}";
          exec = "${cavaVisualizerScript}/bin/waybar-cava";
        };

        "group/hardware" = {
          orientation = "horizontal";
          drawer = {
            transition-duration = 500;
            children-class = "not-cpu";
            transition-left-to-right = true;
          };
          modules = [
            "cpu" # First element is the "group leader" and won't ever be hidden
            "memory"
            "custom/cpu_temp"
            "custom/gpu_temp"
          ];
        };

        cpu = {
          interval = 1;
          format = "  {usage:>2}%";
        };

        memory = {
          interval = 30;
          format = " {}%";
          max-length = 10;
        };

        "custom/cpu_temp" = {
          exec = "sensors | grep -A 0 'Tdie\\|Tctl' | head -1 | awk '{print $2}' | sed 's/+//;s/°C//'";
          format = " {}°C";
          interval = 5;
          tooltip = false;
        };

        "custom/gpu_temp" = {
          exec = "sensors | grep -A 0 'edge\\|junction' | head -1 | awk '{print $2}' | sed 's/+//;s/°C//'";
          format = "   {}°C";
          interval = 5;
          tooltip = false;
        };

        # Center Modules
        "hyprland/workspaces" = {
          format = "{icon}";
          format-icons = {
            active = "";
            default = "";
          };
        };

        # Right Modules
        "hyprland/language" = {
          format = "{}";
          "format-en" = "us";
          "format-ru" = "zov";
          "keyboard-name" = "-------gaming-keyboard";
        };

        network = {
          "format-wifi" = "󰤢";
          "format-ethernet" = "󰈀";
          "format-disconnected" = "󰤠";
          interval = 5;
          "tooltip-format" = "{essid} ({signalStrength}%)";
          "on-click" = "kitty nmtui";
        };

        pulseaudio = {
          format = "{icon}  {volume}%";
          "format-muted" = " ";
          "format-icons" = {
            default = ["" "" " "];
          };
          "scroll-step" = 4.0;
          "max-volume" = 125;
          "on-click" = "pavucontrol";
          "on-click-right" = "bash -c 'wpctl set-mute @DEFAULT_AUDIO_SINK@ toggle'";
        };

        battery = {
          interval = 2;
          states = [
            "good: 95"
            "warning: 30"
            "critical: 15"
          ];
          format = "{icon}  {capacity}%";
          "format-full" = "{icon}  {capacity}%";
          "format-charging" = " {capacity}%";
          "format-plugged" = " {capacity}%";
          "format-alt" = "{icon} {time}";
          "format-icons" = ["" "" "" "" ""];
        };

        "group/group-power" = {
          orientation = "horizontal";
          drawer = {
            transition-duration = 500;
            children-class = "not-power";
            transition-left-to-right = true;
          };
          modules = [
            "custom/power" # First element is the "group leader" and won't ever be hidden
            "custom/quit"
            "custom/lock"
            "custom/reboot"
          ];
        };

        "custom/quit" = {
          format = "󰗼";
          tooltip = false;
          "on-click" = "hyprctl dispatch exit";
        };

        "custom/lock" = {
          format = "󰍁";
          tooltip = false;
          "on-click" = "hyprlock";
        };

        "custom/reboot" = {
          format = "󰜉";
          tooltip = false;
          "on-click" = "reboot";
        };

        "custom/power" = {
          format = "";
          tooltip = false;
          "on-click" = "shutdown now";
        };
      };
    };
  };
}

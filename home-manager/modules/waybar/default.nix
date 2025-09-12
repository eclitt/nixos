{
  programs.waybar = {
    enable = true;
    style = ./style.css;
    settings = {
      mainBar = {
        layer = "top";
        position = "top";
        margin-bottom = 0;
        spacing = 0;

        # Modules - теперь все модули объявляются напрямую
        modules-left = [
          "clock"
          "cpu"
          "memory"
          "custom/cpu_temp"
          "custom/gpu_temp"
          "tray"
        ];

        modules-center = [
          "hyprland/workspaces"
        ];

        modules-right = [
          "hyprland/language"
          "network"
          "pulseaudio"
          "custom/power"
          "custom/quit"
          "custom/lock"
          "custom/reboot"
        ];

        # Clock module
        clock = {
          tooltip = false;
          format = "{:%H:%M:%S  -  %A, %d}";
          interval = 1;
        };

        # Tray module
        tray = {
          icon-size = 16;
          spacing = 5;
        };

        # CPU module
        cpu = {
          interval = 1;
          format = "  {usage:>2}%";
        };

        # Memory module
        memory = {
          interval = 30;
          format = " {}%";
          max-length = 10;
        };

        # CPU temperature module
        "custom/cpu_temp" = {
          exec = "sensors | grep -A 0 'Tdie\\|Tctl' | head -1 | awk '{print $2}' | sed 's/+//;s/°C//'";
          format = " {}°C";
          interval = 5;
          tooltip = false;
        };

        # GPU temperature module
        "custom/gpu_temp" = {
          exec = "sensors | grep -A 0 'edge\\|junction' | head -1 | awk '{print $2}' | sed 's/+//;s/°C//'";
          format = "   {}°C";
          interval = 5;
          tooltip = false;
        };

        # Workspaces module
        "hyprland/workspaces" = {
          format = "{icon}";
          "format-icons" = {
            active = "";
            default = "";
          };
        };

        # Language module
        "hyprland/language" = {
          format = "{}";
          "format-en" = "us";
          "format-ru" = "zov";
          "keyboard-name" = "at-translated-set-2-keyboard";
        };

        # Network module
        network = {
          "format-wifi" = "󰤢";
          "format-ethernet" = "󰈀";
          "format-disconnected" = "󰤠";
          interval = 5;
          "tooltip-format" = "{essid} ({signalStrength}%)";
          "on-click" = "kitty nmtui";
        };

        # PulseAudio module
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

        # Power modules
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

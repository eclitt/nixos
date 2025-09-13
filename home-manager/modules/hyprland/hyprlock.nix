{ config, ... }:

{
  programs.hyprlock = {
    enable = true;
    settings = {
      general = {
        ignore_empty_input = true;
        fail_timeout = 1;
      };

      animations = {
        enabled = true;
      };

      background = {
        monitor = "";
        path = "/home/nsz/Pictures/Wallpapers/normal/24.jpg"; # Используйте абсолютный путь для надежности
        blur_passes = 2;
        blur_size = 4;
      };

      input-field = {
        monitor = "";
        size = "150, 30";
        outline_thickness = 0;
        dots_size = 0.3;
        dots_spacing = 0.5; # Исправлено: dots_space -> dots_spacing
        dots_center = true;
        inner_color = "rgb(FFFFFF)";
        font_color = "rgb(10, 10, 10)";
        font_family = "SF Pro Display Bold";
        placeholder_text = "Input password";
        hide_input = false;
        rounding = -1;
        check_color = "rgb(255, 97, 97)";
        fail_color = "rgb(255, 97, 97)";
        # fail_transition удален, если не поддерживается
        position = "0, 0";
        halign = "center";
        valign = "center";
      };

      label = [
        {
          text = "$USER";
          color = "rgb(FFFFFF)";
          font_size = 100;
          font_family = "SF Pro Display Bold";
          position = "-75, 0";
          halign = "right";
          valign = "center"; # valign: top, center, bottom, none
          shadow_passes = 5;
          shadow_size = 10;
        }
        {
          text = "cmd[update:1000] echo \"$TIME\"";
          color = "rgb(FFFFFF)";
          font_size = 100;
          font_family = "SF Pro Display Bold";
          position = "75, 0";
          halign = "left";
          valign = "center"; # valign: top, center, bottom, none
          shadow_passes = 5;
          shadow_size = 10;
        }
        {
          text = "cmd[update:60000] /home/nsz/.local/bin/scripts/weather.sh"; # Используйте абсолютный путь
          color = "rgb(FFFFFF)";
          font_size = 25;
          font_family = "SF Pro Display Bold";
          position = "-10, 25";
          halign = "center";
          valign = "center"; # Исправлено: 'left' недопустимо. Используйте 'top', 'center', 'bottom' или 'none'.
          shadow_passes = 5;
          shadow_size = 10;
        }
      ];
    };
  };
}

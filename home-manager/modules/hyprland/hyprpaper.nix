{config, pkgs, ...}:
{
  services.hyprpaper = {
    enable = true;
    settings = {
      ipc = "on";
      preload = ["$HOME/Pictures/Wallpapers/normal/3.jpg"];
      wallpaper = [
        ",$HOME/Pictures/Wallpapers/normal/3.jpg"
        "HDMI-A-1,cover:$HOME/Pictures/Wallpapers/normal/3.jpg"
      ];
    };
  };
}


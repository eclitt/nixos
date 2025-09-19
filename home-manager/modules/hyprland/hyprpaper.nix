{config, pkgs, ...}:
{
  services.hyprpaper = {
    enable = true;
    settings = {
      ipc = "on";
      preload = ["$HOME/Pictures/Wallpapers/normal/14.jpg"];
      wallpaper = [
        ",$HOME/Pictures/Wallpapers/normal/14.jpg"
        "HDMI-A-1,cover:$HOME/Pictures/Wallpapers/normal/14.jpg"
      ];
    };
  };
}


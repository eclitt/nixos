{ config, pkgs, ... }:

{
  # Настройка курсора
  home.pointerCursor = {
    name = "graphite-dark";
    package = pkgs.graphite-cursors;
    size = 24;
    gtk.enable = true;
    x11.enable = true;
  };

  # Переменные окружения
  home.sessionVariables = {
    XCURSOR_THEME = "graphite-dark";
    XCURSOR_SIZE = "24";
  };
  gtk = {
    enable = true;
    theme.package = pkgs.graphite-gtk-theme;
    theme.name = "Graphite-dark";
  };
}

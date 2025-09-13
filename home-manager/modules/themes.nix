{ config, pkgs, ... }:

{
  # Настройка курсора
  home.pointerCursor = {
    name = "Graphite-dark";
    package = pkgs.graphite-cursors;
    size = 24;
    gtk.enable = true;
    x11.enable = true;
  };

  # Переменные окружения
  home.sessionVariables = {
    XCURSOR_THEME = "Graphite-dark";
    XCURSOR_SIZE = "24";
  };
}

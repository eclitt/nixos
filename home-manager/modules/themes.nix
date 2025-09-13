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
    theme.package = pkgs.graphite-gtk-theme;
    theme.name = "Graphite-dark";
    
    iconTheme = {
      name = "Papirus-Dark";
      package = pkgs.papirus-icon-theme;
    };

    cursorTheme = {
      name = "graphite-dark";
      package = pkgs.graphite-cursors;
    };
    
  };
}

{ config, pkgs, ... }:

let
  tela-circle-multi = pkgs.tela-circle-icon-theme.override {
    colorVariants = [ "black" ];
  };
in
{
  # Настройка курсора
  home.pointerCursor = {
    name = "graphite-dark-cursors";
    package = pkgs.graphite-cursors;
    size = 24;
    gtk.enable = true;
    x11.enable = true;
  };

  home.sessionVariables = {
    XCURSOR_THEME = "graphite-dark-cursors";
    XCURSOR_SIZE = "24";
    GTK_THEME = "Graphite-Dark";
    ICON_THEME = "Tela-circle-black";
  };

  gtk = {
    enable = true;
    theme = {
      name = "Graphite-Dark";
      package = pkgs.graphite-gtk-theme;
    };
    iconTheme = {
      name = "Tela-circle-black";
      package = tela-circle-multi;
    };
    cursorTheme = {
      name = "graphite-dark-cursors";
      package = pkgs.graphite-cursors;
    };
  };

  qt = {
    enable = true;
    platformTheme.name = "gtk";
    style = {
      name = "adwaita-dark";
      package = pkgs.adwaita-qt;
    };
  };

  home.packages = [
    pkgs.graphite-gtk-theme
    tela-circle-multi
    pkgs.graphite-cursors
    pkgs.adwaita-qt
  ];
}

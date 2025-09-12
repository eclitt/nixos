{ config, pkgs, ... }:

{
  # Включение необходимых служб
  gtk.enable = true;             # Включение GTK конфигурации :cite[6]

  # Настройка GTK темы
  gtk.theme = {
    name = "Graphite-dark";
    package = pkgs.graphite-gtk-theme;
  };

  # Настройка иконок
  gtk.iconTheme = {
    name = lib.mkForce "Tela-circle-dark";
    package = pkgs.tela-circle-icon-theme;
  };

  # Настройка курсора
  home.pointerCursor = {
    name = "Graphite-dark";
    package = pkgs.graphite-cursors;
    size = 24;
    gtk.enable = true;    # Для GTK-приложений :cite[5]
    x11.enable = true;    # Для X11 сессий :cite[5]
  };

  # Дополнительные GTK настройки
  gtk.gtk3.extraConfig = {
    gtk-application-prefer-dark-theme = 1;  # Предпочтение тёмной темы :cite[2]
  };

  gtk.gtk4.extraConfig = {
    gtk-application-prefer-dark-theme = 1;
  };

  # Переменные окружения для гарантированного применения
  home.sessionVariables = {
    GTK_THEME = "Graphite-dark";
    XCURSOR_THEME = "Graphite-dark";
    XCURSOR_SIZE = "24";
    QT_QPA_PLATFORMTHEME = "gtk3";  # Для QT приложений :cite[7]
  };

  # Установка необходимых пакетов
  home.packages = with pkgs; [
    graphite-gtk-theme      # GTK тема
    tela-circle-icon-theme  # Иконки
    graphite-cursors        # Курсоры
  ];

  # Для Hyprland: исправление применения курсора в GNOME-приложениях
  wayland.windowManager.hyprland.settings.exec-once = [
    "gsettings set org.gnome.desktop.interface cursor-theme 'Graphite-dark'"
    "gsettings set org.gnome.desktop.interface cursor-size 24"
  ];
}

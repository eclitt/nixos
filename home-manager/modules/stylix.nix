{ config, pkgs, inputs, ... }:

{
  imports = [ inputs.stylix.homeModules.stylix ];

  home.packages = with pkgs; [
    dejavu_fonts
    jetbrains-mono
    noto-fonts
    noto-fonts-lgc-plus
    texlivePackages.hebrew-fonts
    noto-fonts-emoji
    font-awesome
    powerline-fonts
    powerline-symbols
    nerd-fonts.symbols-only
  ];

  stylix = {
    enable = true;
    polarity = "dark";
    targets = {
      neovim.enable = true;  # Явное указание применить тему к Neovim
      gtk.enable = true;     # Для GTK-приложений
      # Другие цели...
    };

    # GTK тема - ПРАВИЛЬНОЕ ИМЯ ОПЦИИ
    gtk.theme = {
      name = "Graphite-dark";
      package = pkgs.graphite-gtk-theme;
    };

    # Курсоры
    cursor = {
      name = "Graphite-dark";
      package = pkgs.graphite-cursors;
      size = 24;
    };

    # Иконки
    iconTheme = {
      name = "Tela-circle-dark";
      package = pkgs.tela-circle-icon-theme;
    };

    fonts = {
      emoji = {
        name = "Noto Color Emoji";
        package = pkgs.noto-fonts-color-emoji;
      };
      monospace = {
        name = "JetBrains Mono";
        package = pkgs.jetbrains-mono;
      };
      sansSerif = {
        name = "Noto Sans";
        package = pkgs.noto-fonts;
      };
      serif = {
        name = "Noto Serif";
        package = pkgs.noto-fonts;
      };
    };
  };
}

{ config, pkgs, ... }:

{
  # Включение и настройка Mako
  services.mako = {
    enable = true;
    settings = {
      # Основные параметры стиля
      background-color = "#000000"; # Чёрный фон
      text-color = "#FFFFFF"; # Белый текст
      border-color = "#ffffff"; # Серый цвет границы для акцента
      progress-color = "over #ffffff"; # Цвет индикатора прогресса :cite[1]:cite[4]
      border-size = 1; # Размер границы
      border-radius = 5; # Желаемые закругления в 5 пикселей :cite[1]:cite[4]:cite[5]
      # Размеры и отступы
      width = 300;
      height = 120;
      margin = "10"; # Внешний отступ :cite[1]:cite[4]
      padding = "15"; # Внутренний отступ :cite[1]:cite[4]
      # Параметры текста
      font = "sans-serif 10"; # Шрифт :cite[1]:cite[4]
      markup = true; # Включение разметки Pango :cite[1]:cite[4]
      text-alignment = "center"; # Выравнивание текста по центру :cite[1]:cite[4]
      # Поведение уведомлений
      default-timeout = 10000; # Время показа уведомления (10 сек) :cite[1]:cite[4]
      ignore-timeout = false; # Не игнорировать таймауты приложений :cite[1]:cite[4]
      group-by = "app-name"; # Группировать уведомления по приложению :cite[1]:cite[4]
      sort = "-time"; # Сортировка: новые сверху :cite[1]:cite[4]
      # Разное
      actions = true; # Включение действий в уведомлениях :cite[1]:cite[4]
      history = true; # Включение истории уведомлений :cite[1]:cite[4]
      max-visible = 5; # Максимум видимых уведомлений :cite[1]:cite[4]
      layer = "overlay"; # Слой поверх всех окон :cite[1]:cite[4]
      anchor = "top-right"; # Позиция - сверху справа :cite[1]:cite[4]
    };
  };
}

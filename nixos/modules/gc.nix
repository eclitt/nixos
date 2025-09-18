{ config, pkgs, ... }:

{
  # Автоматическая сборка мусора
  nix = {
    gc = {
      # Включить автоматическую сборку мусора
      automatic = true;
      # Запускать по расписанию (еженедельно в 03:15 по ночам)
      dates = "weekly 03:15";
      # Удалять старые поколения и ненужные пакеты
      options = "--delete-older-than 7d";
    };
    
    # Дополнительные настройки оптимизации хранилища
    settings = {
      auto-optimise-store = true;
      # Очищать хранилище при нехватке места
      min-free = 500000000;  # 500MB
      max-free = 1000000000; # 1GB
    };
  };

  # Ограничить количество сохраняемых поколений системы
  # boot.loader.systemd-boot.configurationLimit = 5;
  boot.loader.grub.configurationLimit = 5;

  # Ограничить количество поколений для пользовательских профилей
  nix.extraOptions = ''
    min-free = ${toString config.nix.settings.min-free}
    max-free = ${toString config.nix.settings.max-free}
    keep-outputs = true
    keep-derivations = true
  '';
  
  # Сервис для очистки /tmp
  systemd.tmpfiles.rules = [
    "d /tmp 1777 root root 7d"
  ];
}

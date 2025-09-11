{
  boot.loader = {
    systemd-boot.enable = false;
    # Для UEFI систем
    efi = {
      canTouchEfiVariables = true;
      efiSysMountPoint = "/boot"; # Стандартный путь для EFI раздела
    };    
    # Включение GRUB
    grub = {
      enable = true;
      efiSupport = true;
      device = "nodev";
      
      # Дополнительные настройки (опционально)
      useOSProber = true; # Обнаружение других ОС
    };
  };
}

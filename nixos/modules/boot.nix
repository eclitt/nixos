{
  boot.loader = {
    # Включение GRUB
    grub = {
      enable = true;
      # Для UEFI систем
      efiSupport = true;
      # Для BIOS систем (раскомментируйте и укажите устройство)
      device = "/dev/sda";
      
      # Дополнительные настройки (опционально)
      useOSProber = true; # Обнаружение других ОС
    };
    
    # Для UEFI систем
    efi = {
      canTouchEfiVariables = true;
      efiSysMountPoint = "/boot"; # Стандартный путь для EFI раздела
    };
    
    # Отключение systemd-boot (если был включен)
    systemd-boot.enable = false;
  };
}

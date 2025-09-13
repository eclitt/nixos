# /etc/nixos/modules/video.nix
{ config, pkgs, ... }:

{
  # Включение поддержки AMD GPU
  hardware.opengl = {
    enable = true;
    driSupport32Bit = true;
    
    extraPackages = with pkgs; [
      # Основные драйверы AMD
      amdvlk
      
      # VAAPI поддержка
      libva
      libva-utils
      vaapiVdpau
      libvdpau-va-gl
      
      # Vulkan поддержка
      vulkan-loader
      vulkan-validation-layers
    ];
    
    extraPackages32 = with pkgs.pkgsi686Linux; [
      # 32-битные драйверы для совместимости
      amdvlk
      libva
    ];
  };

  # Настройки для Wayland с AMD
  environment.variables = {
    LIBVA_DRIVER_NAME = "radeonsi";
    VDPAU_DRIVER = "radeonsi";
    GBM_BACKEND = "radeonsi";
    WLR_RENDERER = "vulkan";
    AMD_VULKAN_ICD = "RADV";
  };

  # Параметры ядра для AMD
  boot.kernelParams = [
    "amdgpu.ppfeaturemask=0xffffffff"
    "radeon.si_support=0"
    "radeon.cik_support=0" 
    "amdgpu.si_support=1"
    "amdgpu.cik_support=1"
  ];

  # Дополнительные системные пакеты
  environment.systemPackages = with pkgs; [
    # Мониторинг и утилиты
    radeontop
    clinfo
    
    # Тестирование
    glmark2
    vkmark
    vulkan-tools
    
    # Разгон и настройка (опционально)
    corectrl
  ];

  # Для процессора Ryzen 7 7700 (интегрированная графика)
  hardware.graphics = {
    enable = true;
    enable32Bit = true;
    extraPackages = with pkgs; [
      # Драйверы для интегрированной графики Ryzen
      amdvlk
      libva
      vaapiVdpau
    ];
  };

  # Настройки power management для Ryzen
  powerManagement.cpuFreqGovernor = "schedutil";
  
  # Микроcode обновления для стабильности
  hardware.cpu.amd.updateMicrocode = true;
}

# /etc/nixos/modules/video.nix
{ config, pkgs, ... }:

{
  # Включение аппаратного ускорения для Intel
  hardware.graphics = {
    enable = true;
    enable32Bit = true;
    extraPackages = with pkgs; [
      intel-media-driver          # Для аппаратного ускорения
      vaapiIntel                  # VAAPI для Intel
      vaapiVdpau                  # VDPAU через VAAPI
      libvdpau-va-gl              # VDPAU совместимость
      intel-compute-runtime       # OpenCL поддержка
      intel-vulkan-intel          # Vulkan драйвер
    ];
    extraPackages32 = with pkgs.pkgsi686Linux; [
      vaapiIntel
      libva
    ];
  };

  # Настройки для Wayland с Intel
  environment.variables = {
    LIBVA_DRIVER_NAME = "iHD";
    VDPAU_DRIVER = "va_gl";
  };

  # Дополнительные системные пакеты
  environment.systemPackages = with pkgs; [
    mesa
    vulkan-tools
    glxinfo
  ];
}

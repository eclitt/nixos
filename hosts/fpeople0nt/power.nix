{ config, pkgs, ... }:

{
  services.power-profiles-daemon = {
    enable = true;
  };
  # Для мониторинга можно включить powertop
  powerManagement.powertop.enable = true;
}

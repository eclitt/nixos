{ config, pkgs, ... }:

{
  services.tlp = {
    enable = true;
    settings = {

      # 1. Управление CPU
      CPU_SCALING_GOVERNOR_ON_AC = "performance";
      CPU_SCALING_GOVERNOR_ON_BAT = "powersave";
      CPU_MIN_PERF_ON_AC = 0;
      CPU_MAX_PERF_ON_AC = 100;
      CPU_MIN_PERF_ON_BAT = 0;
      CPU_MAX_PERF_ON_BAT = 50;
      CPU_BOOST_ON_AC = 1;
      CPU_BOOST_ON_BAT = 0;
      CPU_ENERGY_PERF_POLICY_ON_AC = "performance";
      CPU_ENERGY_PERF_POLICY_ON_BAT = "power";

      # 2. Здоровье батареи
      #START_CHARGE_THRESH_BAT0 = 40;
      #STOP_CHARGE_THRESH_BAT0 = 80;

      # 3. Управление периферией
      # PCIE_ASPM_ON_AC = "powersave";
      # PCIE_ASPM_ON_BAT = "powersupersave";
      #RUNTIME_PM_ON_AC = "on";
      #RUNTIME_PM_ON_BAT = "on";
      # USB_AUTOSUSPEND = 1;

      # 4. Управление диском
      # DISK_APM_LEVEL_ON_AC = "254";
      # DISK_APM_LEVEL_ON_BAT = "128";

      # 5. Дополнительно (опционально)
      #WIFI_PWR_ON_AC = 1;
      #WIFI_PWR_ON_BAT = 5;
      #DEVICES_TO_DISABLE_ON_STARTUP = "bluetooth"; # Раскомментируйте, если не нужен Bluetooth

    };
  };

  # Важно: Убедитесь, что power-profiles-daemon отключен, если используете TLP!
  services.power-profiles-daemon.enable = false;

  # Для мониторинга можно включить powertop
  powerManagement.powertop.enable = true;
}

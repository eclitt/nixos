{ config, pkgs, ... }:

{
  services.tlp = {
    enable = true;
    settings = {
      # Оптимизация звука (1 или 0)
      SOUND_POWER_SAVE_ON_AC=1;
      SOUND_POWER_SAVE_ON_BAT=1;
      SOUND_POWER_SAVE_CONTROLLER=Y; # (Y or N)

      # Battery live
      START_CHARGE_THRESH_BAT0=75; # Max 
      STOP_CHARGE_THRESH_BAT0=80; # Min
      RESTORE_THRESHOLDS_ON_BAT=0; # pereconfiguracia posle otlucheniya
      # Driver for battery 
      NATACPI_ENABLE=1; 
      TPSMAPI_ENABLE=1;
      
      # Optical drive
      BAY_POWEROFF_ON_AC=0;
      BAY_POWEROFF_ON_BAT=0;
      BAY_DEVICE=sr0;

      # Disc
      DISK_DEVICES="nvme0n1 sda";
      DISK_APM_LEVEL_ON_AC="254 254";
      DISK_APM_LEVEL_ON_BAT="128 128";
      DISK_APM_CLASS_DENYLIST="usb ieee1394"; #USB ne ubirat!!!
      DISK_SPINDOWN_TIMEOUT_ON_AC="0 0";
      DISK_SPINDOWN_TIMEOUT_ON_BAT="0 0";
      DISK_IOSCHED="keep keep";
      SATA_LINKPWR_ON_AC="max_performance";
      SATA_LINKPWR_ON_BAT="med_power_with_dipm";
      #SATA_LINKPWR_DENYLIST="host1"
      AHCI_RUNTIME_PM_ON_AC=on;
      AHCI_RUNTIME_PM_ON_BAT=on;
      AHCI_RUNTIME_PM_TIMEOUT=15;

      # File system
      DISK_IDLE_SECS_ON_AC=0;
      DISK_IDLE_SECS_ON_BAT=2;
      MAX_LOST_WORK_SECS_ON_AC=15;
      MAX_LOST_WORK_SECS_ON_BAT=60;

      # Graphics
      INTEL_GPU_MIN_FREQ_ON_AC=200;
      INTEL_GPU_MIN_FREQ_ON_BAT=200;
      INTEL_GPU_MAX_FREQ_ON_AC=750;
      INTEL_GPU_MAX_FREQ_ON_BAT=375;
      INTEL_GPU_BOOST_FREQ_ON_AC=750;
      INTEL_GPU_BOOST_FREQ_ON_BAT=375;

      # Network
      WIFI_PWR_ON_AC=off;
      WIFI_PWR_ON_BAT=on;
      WOL_DISABLE=N;
      
      # Platform
      PLATFORM_PROFILE_ON_AC=performance;
      PLATFORM_PROFILE_ON_BAT=low-power;
      MEM_SLEEP_ON_AC=s2idle;
      MEM_SLEEP_ON_BAT=s2idle;

      # Processor
      CPU_DRIVER_OPMODE_ON_AC=active;
      CPU_DRIVER_OPMODE_ON_BAT=active;
      CPU_SCALING_GOVERNOR_ON_AC=performance;
      CPU_SCALING_GOVERNOR_ON_BAT=powersave;
      CPU_SCALING_MIN_FREQ_ON_AC=800000;
      CPU_SCALING_MIN_FREQ_ON_BAT=800000;
      CPU_SCALING_MAX_FREQ_ON_AC=2001000;
      CPU_SCALING_MAX_FREQ_ON_BAT=1000500;
      CPU_MIN_PERF_ON_AC=0;
      CPU_MAX_PERF_ON_AC=100;
      CPU_MIN_PERF_ON_BAT=0;
      CPU_MAX_PERF_ON_BAT=50;
      CPU_ENERGY_PERF_POLICY_ON_AC=performance;
      CPU_ENERGY_PERF_POLICY_ON_BAT=balance_power;
      CPU_BOOST_ON_AC=1;
      CPU_BOOST_ON_BAT=1;
      CPU_HWP_DYN_BOOST_ON_AC=1;
      CPU_HWP_DYN_BOOST_ON_BAT=1;

      # Radio

      RESTORE_DEVICE_STATE_ON_STARTUP=0;
      DEVICES_TO_DISABLE_ON_STARTUP="";
      DEVICES_TO_ENABLE_ON_STARTUP="";
      DEVICES_TO_DISABLE_ON_SHUTDOWN="";
      DEVICES_TO_ENABLE_ON_SHUTDOWN="";
      DEVICES_TO_ENABLE_ON_AC="";
      DEVICES_TO_DISABLE_ON_BAT="";
      DEVICES_TO_DISABLE_ON_BAT_NOT_IN_USE="";
      DEVICES_TO_DISABLE_ON_LAN_CONNECT="";
      DEVICES_TO_DISABLE_ON_WIFI_CONNECT="";
      DEVICES_TO_DISABLE_ON_WWAN_CONNECT="";
      DEVICES_TO_ENABLE_ON_LAN_DISCONNECT="";
      DEVICES_TO_ENABLE_ON_WIFI_DISCONNECT="";
      DEVICES_TO_ENABLE_ON_WWAN_DISCONNECT="";
      DEVICES_TO_ENABLE_ON_DOCK="";
      DEVICES_TO_DISABLE_ON_DOCK="";
      DEVICES_TO_ENABLE_ON_UNDOCK="wifi";
      DEVICES_TO_DISABLE_ON_UNDOCK="";

      # Runtime ASPM
      RUNTIME_PM_ON_AC=on;
      RUNTIME_PM_ON_BAT=on;
      RUNTIME_PM_DENYLIST="";
      RUNTIME_PM_DRIVER_DENYLIST="";
      RUNTIME_PM_ENABLE="";
      RUNTIME_PM_DISABLE="";
      PCIE_ASPM_ON_AC=default;
      PCIE_ASPM_ON_BAT=default;

      # USB
      USB_AUTOSUSPEND=1;
      USB_DENYLIST="";
      USB_EXCLUDE_AUDIO=1;
      USB_EXCLUDE_BTUSB=1;
      USB_EXCLUDE_PHONE=1;
      USB_EXCLUDE_PRINTER=1;
      USB_EXCLUDE_WWAN=0;
      USB_ALLOWLIST="";
      USB_AUTOSUSPEND_DISABLE_ON_SHUTDOWN=1;


    };
  };

  # Важно: Убедитесь, что power-profiles-daemon отключен, если используете TLP!
  services.power-profiles-daemon.enable = false;

  # Для мониторинга можно включить powertop
  powerManagement.powertop.enable = true;
}

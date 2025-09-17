{ config, pkgs, ... }:

{
  # Включение Thunar с плагинами
  home.packages = with pkgs; [
    xfce.thunar
    xfce.thunar-archive-plugin    # Архивирование
    xfce.thunar-volman           # Автомонтирование устройств
    xfce.thunar-media-tags-plugin # Метаданные медиа
  ];

  # Полная конфигурация Thunar
  xdg.configFile = {
    # Основные настройки
    "Thunar/thunarrc".text = ''
      [Settings]
      LastShowHidden=TRUE
      LastWindowWidth=1024
      LastWindowHeight=768
      DefaultView=ThunarDetailsView
      LastLocationBar=ThunarLocationButtons
      LastStatusbarVisible=TRUE
      LastToolbarVisible=TRUE
    '';

    # Пользовательские действия
    "Thunar/uca.xml".text = ''
      <?xml version="1.0" encoding="UTF-8"?>
      <actions>
        <action>
          <icon>utilities-terminal</icon>
          <name>Open Terminal Here</name>
          <unique-id>$(date +%s%N)</unique-id>
          <command>${pkgs.kitty}/bin/kitty --working-directory %f</command>
          <description>Open Kitty terminal in this directory</description>
          <patterns>*</patterns>
          <directories/>
        </action>
        
        <action>
          <icon>code</icon>
          <name>Open in VSCode</name>
          <unique-id>$(date +%s%N | cut -c1-13)</unique-id>
          <command>code %f</command>
          <description>Open in Visual Studio Code</description>
          <patterns>*</patterns>
        </action>
      </actions>
    '';

    # Горячие клавиши
    "Thunar/accels.scm".text = ''
      (gtk_accel_path "<Actions>/ThunarStandardView/properties" "<Primary>i")
      (gtk_accel_path "<Actions>/ThunarLauncher/open" "<Primary>o")
      (gtk_accel_path "<Actions>/ThunarStandardView/rename" "F2")
    '';
  };

  # Настройки MIME types для ассоциаций файлов
  xdg.mimeApps = {
    enable = true;
    defaultApplications = {
      "inode/directory" = [ "thunar.desktop" ];
    #  "text/plain" = [ "code.desktop" ];
    #  "application/pdf" = [ "org.pwmt.zathura.desktop" ];
    };
  };
}

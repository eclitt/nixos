{ config, pkgs, ... }:

{
  home.file.".local/bin/scripts" = {
    source = pkgs.fetchFromGitHub {
      owner = "eclitt";
      repo = "scripts";
      rev = "main"; # или конкретный коммит/тег
      sha256 = "0000000000000000000000000000000000000000000000000000"; # Замените после первой попытки
    };
      
      # Делаем все скрипты исполняемыми
    onChange = let
      scriptsDir = "/home/nsz/.local/bin/scripts";
    in ''
      echo "Making all scripts executable in ${scriptsDir}"
      chmod -R +x ${scriptsDir}
    '';
  };
}

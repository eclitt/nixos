{ config, pkgs, ... }:

{
 # home.packages = with pkgs; [
 #   zsh
 #   oh-my-zsh
 #   zsh-powerlevel10k
 # ];
  # Включение Zsh
 # programs.zsh = {
 #   enable = true;
    #autosuggestions.enable = true; # Включение автоматических предложений
 #   shellAliases = { # Псевдонимы команд
 #   };
  };

  # Настройка Oh My Zsh
 # programs.zsh.oh-my-zsh = {
 #   enable = true;
 #   plugins = []; # Плагины
 #   theme = "powerlevel10k"; # Тема (можно изменить на "robbyrussell", "af-magic", "powerlevel10k/powerlevel10k" и др.)
 # };

  # Настройка терминала Kitty
  programs.kitty = {
    enable = true;
    settings = {
      confirm_os_window_close = 0;
      font_size = 12;
      font_family = "JetBrains Mono"; # Рекомендуется использовать Nerd Font
      bold_font = "auto";
      italic_font = "auto";
      bold_italic_font = "auto";
      window_pading_width = 15;
      cursor_trail = 3;
    };
  };
}

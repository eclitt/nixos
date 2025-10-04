{ config, pkgs, ... }:

{
  programs.kitty = {
    enable = true;
    settings = {
      confirm_os_window_close = 0;
      font_size = 12;
      font_family = "JetBrains Mono";
      bold_font = "auto";
      italic_font = "auto";
      bold_italic_font = "auto";
      window_padding_width = 7;
      cursor_trail = 3;
    };
  };
}

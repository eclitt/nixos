{
  programs.wofi = {
    enable = true;
    style = ./style.css;
    settings = {
      
    };
  };

  xdg.configFile."wofi/wallpaper.conf".text = ''
    # Window settings
    width=800
    height=600
    location=center
    show=dmenu
    prompt=Select Wallpaper
    layer=overlay

    # Layout
    columns=3
    image_size=250x141 # 16:9
    allow_images=true
    insensitive=true
    hide_scroll=true
    sort_order=alphabetical

    # Style
    style_path=~/.config/wofi/wallpaper.css
  '';
  xdg.configFile."wofi/wallpaper.css".text = ''
    window {
        margin: 0px;
        border: 2px solid #ffffff; /* Темно-серый акцент */
        border-radius: 12px;
        background-color: rgba(25, 25, 25, 0.95); /* Почти черный, полупрозрачный */
        font-family: "JetBrainsMono Nerd Font", "FiraCode Nerd Font", monospace;
        font-size: 14px;
        font-weight: 500;
    }

    #input {
        all: unset;
        margin: 15px;
        padding: 8px 12px;
        border: 1px solid #555555;
        border-radius: 8px;
        color: #e0e0e0;
        background-color: #1a1a1a;
        box-shadow: inset 0 0 0 1px #333333;
        min-height: 28px;
    }

    #input:focus {
        border: 1px solid #888888;
        box-shadow: inset 0 0 0 1px #666666;
    }

    #inner-box {
        margin: 0px;
        border: none;
        border-radius: 8px;
        background-color: transparent;
    }

    #outer-box {
        margin: 5px;
        border: none;
        border-radius: 8px;
        background-color: transparent;
        padding: 10px;
    }

    #scroll {
        margin: 0px;
        border: none;
    }

    #text {
        margin: 3px 5px;
        border: none;
        color: #d0d0d0;
    }

    #text:selected {
        color: #0a0a0a;
        font-weight: 600;
    }

    #entry {
        border: none;
        border-radius: 6px;
        background-color: transparent;
    }

    #entry:hover {
        background-color: #333333;
    }

    #entry:selected {
        background-color: #e0e0e0; /* Светло-серый акцент */
        outline: none;
    }

    #entry image {
        color: #aaaaaa;
    }

    #prompt {
        margin: 0;
        color: #aaaaaa;
        font-size: 13px;
    }

    #img {
        margin: 2px;
        padding-left: 4px;
        border-radius: 4px;
    }
  '';
}

{ pkgs, ... }:{
  nixpkgs.config.allowUnfree = true;
  home.packages = with pkgs; [
    # Libs
    playerctl # player lib
    gtk3 
    gtk4
    gtk-layer-shell
    nftables # Lib for Zapret Discord
    lm_sensors # Lib for sensors on waybar
    gvfs # Lib for Dynamic volumes (thunar)
    pavucontrol # Volume
    # Chats
    ayugram-desktop # Telegram
    vesktop # Discord
    # Text editors
    vim
    neovim
    obsidian # Notes
    # Cli utilites
    zfxtop  # htop
    fastfetch
    cava # Music visulisation
    cmatrix # Matrix
    peaclock # Clock
    unzip # Zip manager
    ranger # Cli File manager
    pipes # Cli screensaver
    mpv # Cli media player
    # Other Programs
    firefox
    # Games pkgs
    wineWowPackages.waylandFull #wine
    gamemode # Gamemode for linux
    gamescope # Gamescope
    mangohud # Fps counter
    steam # Steam game launcher
    shtris # Tetris CLI
  ];
}

{ pkgs, ... }:{
  nixpkgs.config.allowUnfree = true;
  home.packages = with pkgs; [
    obsidian
    mpv
    ayugram-desktop
    vesktop
    cliphist
    htop
    playerctl
    unzip
    
    vim

    wl-clipboard
    xdg-desktop-portal-gtk
    xdg-desktop-portal-hyprland
  ];
}

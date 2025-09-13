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
    xfce.thunar
    swww
    mako
    kitty
    hyprlock
    hyprshot
    ranger
    firefox
    neovim
    gtk3
    gtk4
    nftables
  ];
}

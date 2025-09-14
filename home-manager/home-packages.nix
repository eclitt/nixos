{ pkgs, ... }:{
  nixpkgs.config.allowUnfree = true;
  home.packages = with pkgs; [
    obsidian
    mpv
    ayugram-desktop
    vesktop
    htop
    playerctl
    unzip
    vim
    xfce.thunar
    kitty
    ranger
    firefox
    neovim
    gtk3
    gtk4
    nftables
    gvfs
  ];
}

{ pkgs, ... }:{
  nixpkgs.config.allowUnfree = true;
  home.packages = with pkgs; [
    obsidian
    mpv
    ayugram-desktop
    vesktop
    zfxtop
    playerctl
    unzip
    vim
    kitty
    ranger
    firefox
    neovim
    gtk3
    gtk4
    gtk-layer-shell
    nftables
    gvfs
    lm_sensors
    pavucontrol
    cava
  ];
}

# /etc/nixos/modules/network.nix
{ config, pkgs, ... }:

{
  networking.networkmanager.enable = true;

  environment.systemPackages = with pkgs; [
    networkmanagerapplet
  ];
}

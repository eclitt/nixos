{ pkgs, stateVersion, hostname, ... }:

{
  imports = [
    ./hardware-configuration.nix
    ./local-packages.nix
    ../../nixos/modules
  ];

  environment.systemPackages = [ pkgs.home-manager ];

  networking.hostName = hostname;
  boot.kernelParams = [ "pcie_port_pm=off" ];
  system.stateVersion = stateVersion;
}

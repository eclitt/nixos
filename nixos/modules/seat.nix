{ config, pkgs, ... }:

{
  services.seatd = {
    enable = true;
    logLevel = "debug";
  };
}

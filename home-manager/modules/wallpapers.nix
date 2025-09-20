{ config, pkgs, lib, ... }:

{
  home.file."/home/nsz/Pictures/Wallpapers".source = pkgs.fetchFromGitHub {
    owner = "eclitt";
    repo = "wallpapers";
    rev = "master";
    sha256 = "RP6dRJgGgdTXMROEux/X9Z4IkSjImPlaRq1FPBUd/fQ=";
  };
}

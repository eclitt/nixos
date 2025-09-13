{ config, pkgs, lib, ... }:

{
  home.file."/home/nsz/Pictures/Wallpapers".source = pkgs.fetchFromGitHub {
    owner = "eclitt";
    repo = "wallpapers";
    rev = "master";
    sha256 = "0000000000000000000000000000000000000000000000000000";
  };
}

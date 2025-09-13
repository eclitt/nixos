{ config, pkgs, lib, ... }:

{
  home.file."/home/nsz/Pictures/Wallpapers".source = pkgs.fetchFromGitHub {
    owner = "eclitt";
    repo = "wallpapers";
    rev = "master";
    sha256 = "79Hi39ntmupgel2+NeW2TAdWi2OjZHUhyhtvOPQgL4E=";
  };
}

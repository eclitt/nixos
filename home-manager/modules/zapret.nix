{ config, pkgs, lib, ... }:

{
  home.file."/home/nsz/.local/bin/zapret".source = pkgs.fetchFromGitHub {
    owner = "Sergeydigl3";
    repo = "zapret-discord-youtube-linux";
    rev = "stable3";
    sha256 = "7rCjdMn/ztCiSSjIIUKCy1NPAmsCfZ+Qe/jACXabE34=";
  };
}

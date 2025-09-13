{ config, pkgs, lib, ... }:

{
  home.file."/home/nsz/.local/bin/".source = pkgs.fetchFromGitHub {
    owner = "Sergeydigl3";
    repo = "zapret-discord-youtube-linux";
    rev = "stable3";
    sha256 = " 79514ba4b9802ab4184097f76e59f22854ae7bff";
  };
}

{ pkgs, user, ... }:
{
  programs.bash = {
    shellAliases = {
      homerb = "home-manager switch --flake /home/nsz/nixos/#nsz";
      nixrbp = "sudo nixos-rebuild switch --flake /home/nsz/nixos/#fpeople0pc";
      nixrbn = "sudo nixos-rebuild switch --flake /home/nsz/nixos/#fpeople0nt";
      zapret = "sudo bash /home/nsz/zapret-discord-youtube-linux/main_script.sh";
    };
  };
  users = {
    defaultUserShell = pkgs.bash;
    users.${user} = {
      isNormalUser = true;
      extraGroups = [
        "wheel"
        "networkmanager"
        "video"
        "input"
        "seat"
        "render"
      ];
    };
  };
}  

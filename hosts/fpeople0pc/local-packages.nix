{ pkgs, ... }: {
  
  environment.systemPackages = with pkgs; [
    gcc
    vim

  ];
  imports = [
    ./sddm.nix
    ./video.nix
  ];
}

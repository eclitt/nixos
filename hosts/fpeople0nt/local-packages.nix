{ pkgs, ... }: {
  environment.systemPackages = with pkgs; [
    gcc
  ];
  import = [ 
    ./sddm.nix
  ];
}

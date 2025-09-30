{ pkgs, ... }: 
#let
#  dotify-pkg = pkgs.callPackage ./dotify.nix {};
#in
{
   # Включение nix-ld
  #programs.nix-ld.enable = true;
  
  # Опционально: можно указать библиотеки, если программе нужны специфические
  #programs.nix-ld.libraries = with pkgs; [
    # stdenv.cc.cc.lib
    # openssl
    # gtk3
  #];

  environment.systemPackages = with pkgs; [
    gcc
    vim
  #  dotify-pkg
  ];
  imports = [
    ./sddm.nix
    ./video.nix
  ];
}

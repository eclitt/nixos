# /etc/nixos/hosts/fpeople0nt/sddm.nix
{ pkgs, inputs, ... }:
let
  # an exhaustive example can be found in flake.nix
  sddm-theme = inputs.silentSDDM.packages.${pkgs.system}.default.override {
    theme = "rei"; # select the config of your choice
  };
in
{
  # include the test package which can be run using test-sddm-silent
  environment.systemPackages = [ sddm-theme sddm-theme.test ];
  qt.enable = true;
  
  services.displayManager.sddm = {
    enable = true;
    wayland.enable = true;  # Это отдельная опция!
    package = pkgs.kdePackages.sddm; # use qt6 version of sddm
    theme = sddm-theme.pname;
    extraPackages = sddm-theme.propagatedBuildInputs;
    settings = {
      General = {
        GreeterEnvironment = "QML2_IMPORT_PATH=${sddm-theme}/share/sddm/themes/${sddm-theme.pname}/components/,QT_IM_MODULE=qtvirtualkeyboard";
        InputMethod = "qtvirtualkeyboard";
      };
    };
  };
}

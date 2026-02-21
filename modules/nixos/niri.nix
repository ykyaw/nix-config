{ pkgs, ... }:

{
  services.displayManager.ly.enable = true;

  programs.niri.enable = true;

  environment = {
    systemPackages = with pkgs; [
      fuzzel
      xwayland-satellite
    ];
    sessionVariables = {
      ELECTRON_OZONE_PLATFORM_HINT = "auto";
      NIXOS_OZONE_WL = "1";
      QT_QPA_PLATFORMTHEME = "gtk3";
    };
  };
}

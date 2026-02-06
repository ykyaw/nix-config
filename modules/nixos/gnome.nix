{ pkgs, ... }:

{
  services = {
    displayManager.gdm.enable = true;
    desktopManager.gnome.enable = true;
  };

  environment = {
    gnome.excludePackages = with pkgs; [
      decibels
      epiphany
      gnome-console
      gnome-contacts
      gnome-maps
      gnome-music
      gnome-tour
      showtime
      snapshot
    ];
    systemPackages = with pkgs.gnomeExtensions; [
      appindicator
      blur-my-shell
      caffeine
      hot-edge
    ];
  };

  programs.dconf.enable = true;
}

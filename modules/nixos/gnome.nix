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

  system.activationScripts.text = ''
    mkdir -p /var/lib/AccountsService/{icons,users}
    cp ${pkgs.gnome-control-center}/share/pixmaps/faces/coffee2.jpg /var/lib/AccountsService/icons/thatoe
    echo -e "[User]\nIcon=/var/lib/AccountsService/icons/thatoe" > /var/lib/AccountsService/users/thatoe
  '';
}

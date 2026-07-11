{ config, ... }: {
  flake.modules.nixos.gnome = { pkgs, ... }: {
    services = {
      displayManager = {
        autoLogin = {
          enable = true;
          user = config.username;
        };
        gdm.enable = true;
      };
      desktopManager.gnome.enable = true;
    };

    environment.gnome.excludePackages = with pkgs; [
      decibels
      epiphany
      gnome-characters
      gnome-connections
      gnome-console
      gnome-contacts
      gnome-font-viewer
      gnome-maps
      gnome-music
      gnome-tecla
      gnome-tour
      showtime
      snapshot
      totem
      yelp
    ];

    programs.dconf.enable = true;
  };
}

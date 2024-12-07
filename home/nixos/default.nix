{ config, pkgs, ... }:

{
  home = {
    username = "thatoe";
    homeDirectory = "/home/thatoe";
    stateVersion = "24.05";
  };

  programs.home-manager.enable = true;

  gtk = {
    enable = true;
    cursorTheme = {
      name = "Bibata-Modern-Classic";
      package = pkgs.bibata-cursors;
      size = 24;
    };
    iconTheme = {
      name = "Papirus-Dark";
      package = pkgs.papirus-icon-theme.override {
        color = "nordic";
      };
    };
    theme = {
      name = "Nordic-darker";
      package = pkgs.nordic;
    };
  };

  home.pointerCursor = with config.gtk.cursorTheme; {
    inherit name package size;
  };

  xresources.properties = {
    "Xcursor.theme" = config.gtk.cursorTheme.name;
    "Xcursor.size" = config.gtk.cursorTheme.size;
    "Xft.dpi" = 96;
  };
}

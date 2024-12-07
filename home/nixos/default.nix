{ config, pkgs, ... }:

{
  imports = [
    ../shared.nix
  ];

  home.packages = with pkgs; [
    dex
    discord
    docker
    docker-compose
    dunst
    ghostscript
    gnome-keyring
    graphicsmagick
    maim
    mpv
    ncdu
    nemo
    nemo-fileroller
    netcat-gnu
    numlockx
    pavucontrol
    playerctl
    polkit_gnome
    postgresql
    qbittorrent
    redis
    ripgrep
    rofi
    steam
    teams-for-linux
    udiskie
    ungoogled-chromium
    xclip
    xdotool
  ];

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

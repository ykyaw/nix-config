{ config, pkgs, ... }:

{
  imports = [
    ../shared/brave.nix
  ];

  home = {
    username = "thatoe";
    homeDirectory = /home/${config.home.username};
    stateVersion = "23.11";
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
      package = pkgs.papirus-icon-theme;
    };
    theme = {
      name = "Catppuccin-Mocha-Standard-Teal-Dark";
      package = pkgs.catppuccin-gtk.override {
        accents = [ "teal" ];
        variant = "mocha";
      };
    };
  };

  home.pointerCursor = with config.gtk.cursorTheme; { inherit name package size; };
}

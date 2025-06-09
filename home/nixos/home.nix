{ pkgs, ... }:

{
  imports = [
    ../shared/home.nix
  ];

  home = {
    username = "thatoe";
    homeDirectory = "/home/thatoe";
    packages = with pkgs; [
      discord
      ncdu
      qbittorrent
      teams-for-linux
    ];
  };

  programs = {
    chromium.enable = true;
    fish = {
      shellAliases =
        let
          flake = "/home/thatoe/develop/nix-config";
        in
        {
          ns = "sudo nixos-rebuild switch --flake ${flake}";
          nu = "nix flake update --flake ${flake}";
        };
    };
    mpv.enable = true;
  };

  gtk = {
    enable = true;
    iconTheme = {
      name = "Papirus-Dark";
      package = pkgs.papirus-icon-theme;
    };
  };

  home.pointerCursor = {
    name = "Bibata-Modern-Classic";
    package = pkgs.bibata-cursors;
    size = 24;
    gtk.enable = true;
  };
}

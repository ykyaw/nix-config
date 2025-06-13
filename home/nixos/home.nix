{ lib, pkgs, ... }:

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

  wayland.windowManager.sway = {
    enable = true;
    wrapperFeatures.gtk = true;
    config = {
      modifier = "Mod4";
      terminal = "alacritty";
      output.DP-2.resolution = "3440x1440@120Hz";
      input = {
        "type:pointer".accel_profile = "flat";
        "type:keyboard".xkb_numlock = "on";
      };
      defaultWorkspace = "workspace number 1";
      keybindings = lib.mkOptionDefault {
        "Mod1+Space" = "exec rofi -show drun";
      };
    };
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
    rofi = {
      enable = true;
      package = pkgs.rofi-wayland;
    };
  };

  services = {
    dunst.enable = true;
    udiskie.enable = true;
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

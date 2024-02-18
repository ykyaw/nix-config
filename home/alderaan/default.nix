{ config, pkgs, ... }:

{
  imports = [
    ./i3.nix

    ../shared/brave.nix
    ../shared/firefox.nix
    ../shared/fish.nix
    ../shared/git.nix
    ../shared/kitty.nix
    ../shared/starship.nix
    ../shared/vscode.nix
    ../shared/zoxide.nix
  ];

  nixpkgs.config.allowUnfree = true;

  home = {
    username = "thatoe";
    homeDirectory = /home/${config.home.username};
    stateVersion = "23.11";
    packages = with pkgs; [
      azure-functions-core-tools
      discord
      gitkraken
      libreoffice-fresh
      ncdu
      nixpkgs-fmt
      nodejs
      pavucontrol
      qbittorrent
      spotify
      sqlite
      sqlitebrowser
      teams-for-linux
    ] ++ (with pkgs.libsForQt5; [
      dolphin
      kwallet
      kwalletmanager
    ]);
  };

  programs = {
    home-manager.enable = true;

    mpv.enable = true;
    neovim.enable = true;
  };

  services = {
    dunst.enable = true;
    udiskie.enable = true;
  };

  systemd.user = {
    startServices = "sd-switch";
    # Tray target for udiskie
    targets.tray = {
      Unit = {
        Description = "Home Manager System Tray";
        Requires = [ "graphical-session-pre.target" ];
      };
    };
  };

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

  xresources.properties = {
    "Xft.dpi" = 96;
    "Xcursor.size" = 24;
  };
}

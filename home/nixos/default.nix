{ config, pkgs, ... }:

{
  imports = [
    ../shared
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
    bash = {
      enable = true;
      initExtra = ''
        if [[ $(${pkgs.procps}/bin/ps --no-header --pid=$PPID --format=comm) != "fish" && -z ''${BASH_EXECUTION_STRING} ]]
        then
          shopt -q login_shell && LOGIN_OPTION='--login' || LOGIN_OPTION=""
          exec ${pkgs.fish}/bin/fish $LOGIN_OPTION
        fi
      '';
    };
    chromium.extensions = [
      "dnhpnfgdlenaccegplpojghhmaamnnfp" # Augmented Steam
      "kdbmhfkmnlmbkgbabkdealhhbfhlmmon" # SteamDB
      "lcbjdhceifofjlpecfpeimnnphbcjgnc" # xBrowserSync
    ];
    ghostty = {
      enable = true;
      settings = {
        background-opacity = 0.9;
        background-blur-radius = 32;
        font-family = "Comic Code Liguatures";
        font-size = 11;
        theme = "tokyonight";
      };
    };
    fish.shellAliases =
      let
        flake = "${config.home.homeDirectory}/development/nix-config";
      in
      {
        ns = "sudo nixos-rebuild switch --flake ${flake}";
        nu = "nix flake update --flake ${flake}";
      };
    mpv.enable = true;
  };

  gtk = {
    enable = true;
    iconTheme = {
      name = "Papirus-Dark";
      package = pkgs.papirus-icon-theme;
    };
    theme = {
      name = "Tokyonight-Dark";
      package = pkgs.tokyonight-gtk-theme.override {
        colorVariants = [ "dark" ];
        tweakVariants = [ "black" ];
      };
    };
  };

  home.pointerCursor = {
    name = "Bibata-Modern-Classic";
    package = pkgs.bibata-cursors;
    size = 24;
    gtk.enable = true;
  };
}

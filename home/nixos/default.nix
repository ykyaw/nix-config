{ config, pkgs, ... }:

{
  home = {
    username = "thatoe";
    homeDirectory = "/home/thatoe";
    stateVersion = "24.05";
    packages = with pkgs; [
      nixd
      nixfmt-rfc-style
    ];
  };

  programs = {
    home-manager.enable = true;
    fish = {
      enable = true;
      functions.fish_greeting = "";
      interactiveShellInit = "fish_vi_key_bindings";
      shellAliases =
        let
          flake = "${config.home.homeDirectory}/development/nix-config";
        in
        {
          ns = "sudo nixos-rebuild switch --flake ${flake}";
          nu = "nix flake update ${flake}";
        };
    };
    fzf.enable = true;
    kitty = {
      enable = true;
      font.name = "Comic Code Ligatures";
      settings = {
        window_margin_width = 5;
        background_opacity = 0.9;
        background_blur = 32;
      };
      themeFile = "tokyo_night_night";
    };
    starship = {
      enable = true;
      settings.add_newline = false;
    };
    zoxide = {
      enable = true;
      options = [ "--cmd cd" ];
    };
  };
}

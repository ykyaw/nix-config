{
  config,
  lib,
  pkgs,
  ...
}:
{
  home = {
    username = "thatoe";
    homeDirectory = "/home/thatoe";
    stateVersion = "26.05";
  };

  programs = {
    fish = {
      enable = true;
      interactiveShellInit = ''
        set fish_greeting
        fish_vi_key_bindings
      '';
      shellAliases =
        let
          flake = "${config.home.homeDirectory}/Projects/nix-config";
        in
        {
          ns = "nixos-rebuild switch --sudo --flake ${flake}";
          nu = "nix flake update --flake ${flake}";
        };
    };
    fzf.enable = true;
    home-manager.enable = true;
    kitty = {
      enable = true;
      font.name = "Berkeley Mono";
      settings = {
        background_blur = 16;
        background_opacity = 0.9;
        shell = lib.getExe pkgs.fish;
      };
      themeFile = "Catppuccin-Mocha";
    };
    starship = {
      enable = true;
      settings.add_newline = false;
    };
    zoxide.enable = true;
  };
}

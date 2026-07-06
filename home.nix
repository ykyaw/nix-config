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
    ghostty = {
      enable = true;
      settings = {
        font-family = "Berkeley Mono";
        theme = "Catppuccin Mocha";
        command = "${lib.getExe pkgs.fish} -li";
      };
    };
    home-manager.enable = true;
    starship = {
      enable = true;
      settings.add_newline = false;
    };
    zoxide.enable = true;
  };
}

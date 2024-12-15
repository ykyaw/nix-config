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
  programs.home-manager.enable = true;
  };
}

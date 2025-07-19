{ config, pkgs, ... }:

{
  home = {
    username = "thatoe";
    homeDirectory = "/home/thatoe";
    stateVersion = "25.05";
    packages = with pkgs; [
      nixd
      nixfmt-rfc-style
      sbctl
    ];
  };

  programs.home-manager.enable = true;

  programs = {
    fish = {
      enable = true;
      interactiveShellInit = ''
        set fish_greeting
        fish_vi_key_bindings
      '';
      shellAliases =
        let
          flake = "${config.home.homeDirectory}/development/nix-config";
        in
        {
          ns = "sudo nixos-rebuild switch --flake ${flake}";
          nu = "nix flake update --flake ${flake}";
        };
    };
  };
}

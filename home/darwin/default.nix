{ config, pkgs, ... }:

{
  imports = [
    ../shared
  ];

  home.packages = with pkgs; [
    cocoapods
    raycast
  ];

  programs = {
    fish.shellAliases =
      let
        flake = "${config.home.homeDirectory}/development/nix-config#macalania";
      in
      {
        ns = "darwin-rebuild switch --flake ${flake}";
        nu = "nix flake update --flake ${flake}";
      };
    zsh.enable = true;
  };
}

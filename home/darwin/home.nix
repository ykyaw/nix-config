{ pkgs, ... }:

{
  imports = [
    ../shared/home.nix
  ];

  home.packages = with pkgs; [
    cocoapods
    raycast
  ];

  programs.fish.shellAliases =
    let
      flake = "/Users/thatoe/develop/nix-config#macalania";
    in
    {
      ns = "sudo darwin-rebuild switch --flake ${flake}";
      nu = "nix flake update --flake ${flake}";
    };
}

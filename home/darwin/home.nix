{ config, ... }:

{
  imports = [
    ../shared/home.nix
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

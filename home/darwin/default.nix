{ config, ... }:

{
  imports = [
    ../shared
  ];

  programs.fish.shellAliases =
    let
      flake = "${config.home.homeDirectory}/development/nix-config#macalania";
    in
    {
      ns = "darwin-rebuild switch --flake ${flake}";
      nu = "nix flake update --flake ${flake}";
    };
}

{ config, ... }:

{
  programs.fish = {
    enable = true;
    functions = {
      fish_greeting = "";
    };
    shellAbbrs =
      let
        flake = "${config.home.homeDirectory}/Projects/nix-config";
      in
      {
        nrs = "sudo nixos-rebuild --flake ${flake} switch";
        nfu = "nix flake update ${flake}";
        hms = "home-manager switch --flake ${flake}";
      };
  };
}

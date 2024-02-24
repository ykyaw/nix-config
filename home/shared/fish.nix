{ config, pkgs, ... }:

{
  programs.fish = {
    enable = true;
    functions = {
      fish_greeting = "";
      autoclicker = ''
        set pid (pgrep -f "${pkgs.xdotool}/bin/xdotool click --repeat 100 --delay 100 1")
        if test -n "$pid"
          kill $pid
        else
          ${pkgs.xdotool}/bin/xdotool click --repeat 100 --delay 100 1 &
        end
      '';
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

{ pkgs, ... }:

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

  programs.home-manager.enable = true;
}

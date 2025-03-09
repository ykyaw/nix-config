{ pkgs, ... }:

{
  home = {
    username = "thatoe";
    homeDirectory = "/home/thatoe";
    stateVersion = "24.11";
    packages = with pkgs; [
      nixd
      nixfmt-rfc-style
    ];
  };

  programs.home-manager.enable = true;
}

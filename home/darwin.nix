{ pkgs, ... }:

{
  imports = [
    ../modules/home/home.nix
  ];

  home.packages = with pkgs; [
    cocoapods
    docker
    raycast
  ];
}

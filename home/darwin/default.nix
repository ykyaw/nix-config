{ pkgs, ... }:

{
  imports = [
    ../shared.nix
  ];

  home = {
    packages = with pkgs; [
      cocoapods
      raycast
    ];
    file.".hushlogin".text = "";
  };
}

{ pkgs, ... }:

{
  fonts.packages = with pkgs; [
    dejavu_fonts
    fira-code
    inter
    liberation_ttf
    noto-fonts
    noto-fonts-extra
  ];
}

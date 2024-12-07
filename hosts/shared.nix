{ pkgs, ... }:

{
  nix = {
    settings.experimental-features = "nix-command flakes";
    gc = {
      automatic = true;
      options = "--delete-older-than 14d";
    };
    optimise.automatic = true;
  };

  fonts = {
    packages = with pkgs; [
      dejavu_fonts
      inter
      liberation_ttf
      noto-fonts
      noto-fonts-emoji
      noto-fonts-extra
    ];
  };
}

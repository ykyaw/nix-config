{ pkgs, ... }:

{
  nixpkgs.config.allowUnfree = true;

  nix = {
    settings.experimental-features = "nix-command flakes";
    gc = {
      automatic = true;
      options = "--delete-older-than 14d";
    };
    optimise.automatic = true;
  };

  users.users.thatoe.shell = pkgs.fish;

  programs.fish.enable = true;

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

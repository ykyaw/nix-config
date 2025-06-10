{ pkgs, ... }:

{
  nix = {
    gc = {
      automatic = true;
      options = "--delete-older-than 30d";
    };
    optimise.automatic = true;
    settings.experimental-features = "nix-command flakes";
  };

  nixpkgs.config.allowUnfree = true;

  services.postgresql.enable = true;

  fonts.packages = with pkgs; [
    dejavu_fonts
    fira-code
    inter
    liberation_ttf
    noto-fonts
    noto-fonts-extra
  ];
}

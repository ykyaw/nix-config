{ pkgs, ... }:

{
  home = {
    username = "thatoe";
    homeDirectory = "/Users/thatoe";
    stateVersion = "24.05";
    packages = with pkgs; [
      dbeaver-bin
      gitkraken
      neovim
      nixd
      nixfmt-rfc-style
      nodejs_20
      raycast
      spotify
    ];
  };

  programs = {
    home-manager.enable = true;
    chromium = {
      enable = true;
      package = pkgs.brave;
      extensions = [
        { id = "nngceckbapebfimnlniiiahkandclblb"; } # Bitwarden Password Manager
        { id = "mnjggcdmjocbbbhaepdhchncahnbgone"; } # SponsorBlock for YouTube - Skip Sponsorships
      ];
    };
  };
}

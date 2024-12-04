{ pkgs, ... }:

{
  home = {
    username = "thatoe";
    homeDirectory = "/Users/thatoe";
    stateVersion = "24.05";
    packages = with pkgs; [
      cocoapods
      dbeaver-bin
      gitkraken
      neovim
      nixd
      nixfmt-rfc-style
      nodejs_20
      raycast
      spotify
      vscode
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
    kitty = {
      enable = true;
      settings = {
        background_opacity = 0.9;
        background_blur = 32;
        window_margin_width = 5;
      };
      themeFile = "gruvbox-dark-hard";
    };
  };
}

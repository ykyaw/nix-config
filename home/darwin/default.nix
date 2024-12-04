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
    file.".hushlogin".text = "";
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
    fish = {
      enable = true;
      functions.fish_greeting = "";
      interactiveShellInit = "fish_vi_key_bindings";
      shellAliases = {
        ns = "darwin-rebuild switch --flake ~/development/nix-config#macalania";
        nu = "nix flake update --flake ~/development/nix-config";
      };
    };
    fzf.enable = true;
    kitty = {
      enable = true;
      settings = {
        background_opacity = 0.9;
        background_blur = 32;
        window_margin_width = 5;
      };
      themeFile = "gruvbox-dark-hard";
    };
    starship = {
      enable = true;
      settings.add_newline = false;
    };
    zoxide = {
      enable = true;
      options = [ "--cmd cd" ];
    };
  };
}

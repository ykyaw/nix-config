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
      nixd
      nixfmt-rfc-style
      nodejs_20
      postgresql
      raycast
      redis
      spotify
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
      shellAliases = {
        ns = "darwin-rebuild switch --flake ~/development/nix-config#macalania";
        nu = "nix flake update ~/development/nix-config";
      };
    };
    fzf.enable = true;
    kitty = {
      enable = true;
      font.name = "ComicShannsMono Nerd Font";
      settings = {
        background_opacity = 0.9;
        background_blur = 32;
        window_margin_width = 5;
        # Tokyo Night
        background = "#1a1b26";
        foreground = "#c0caf5";
        selection_background = "#283457";
        selection_foreground = "#c0caf5";
        url_color = "#73daca";
        cursor = "#c0caf5";
        cursor_text_color = "#1a1b26";

        active_tab_background = "#7aa2f7";
        active_tab_foreground = "#16161e";
        inactive_tab_background = "#292e42";
        inactive_tab_foreground = "#545c7e";
        tab_bar_background = "#15161e";

        active_border_color = "#7aa2f7";
        inactive_border_color = "#292e42";

        color0 = "#15161e";
        color1 = "#f7768e";
        color2 = "#9ece6a";
        color3 = "#e0af68";
        color4 = "#7aa2f7";
        color5 = "#bb9af7";
        color6 = "#7dcfff";
        color7 = "#a9b1d6";

        color8 = "#414868";
        color9 = "#f7768e";
        color10 = "#9ece6a";
        color11 = "#e0af68";
        color12 = "#7aa2f7";
        color13 = "#bb9af7";
        color14 = "#7dcfff";
        color15 = "#c0caf5";

        color16 = "#ff9e64";
        color17 = "#db4b4b";
      };
    };
    neovim = {
      enable = true;
      defaultEditor = true;
      viAlias = true;
      vimAlias = true;
      vimdiffAlias = true;
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

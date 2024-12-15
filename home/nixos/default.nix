{ config, pkgs, ... }:

{
  home = {
    username = "thatoe";
    homeDirectory = "/home/thatoe";
    stateVersion = "24.05";
    packages = with pkgs; [
      nixd
      nixfmt-rfc-style
    ];
  };

  programs = {
    home-manager.enable = true;
    chromium = {
      enable = true;
      package = pkgs.brave;
      extensions = [
        "dnhpnfgdlenaccegplpojghhmaamnnfp" # Augmented Steam
        "nngceckbapebfimnlniiiahkandclblb" # Bitwarden Password Manager
        "ngonfifpkpeefnhelnfdkficaiihklid" # ProtonDB for Steam
        "mnjggcdmjocbbbhaepdhchncahnbgone" # SponsorBlock for YouTube - Skip Sponsorships
        "kdbmhfkmnlmbkgbabkdealhhbfhlmmon" # SteamDB
        "lcbjdhceifofjlpecfpeimnnphbcjgnc" # xBrowserSync
      ];
    };
    fish = {
      enable = true;
      functions.fish_greeting = "";
      interactiveShellInit = "fish_vi_key_bindings";
      shellAliases =
        let
          flake = "${config.home.homeDirectory}/development/nix-config";
        in
        {
          ns = "sudo nixos-rebuild switch --flake ${flake}";
          nu = "nix flake update ${flake}";
        };
    };
    fzf.enable = true;
    git = {
      enable = true;
      userEmail = "thatoe@pm.me";
      userName = "Ye Thatoe Kyaw";
      signing = {
        signByDefault = true;
        key = "${config.home.homeDirectory}/.ssh/id_ed25519.pub";
      };
      extraConfig.gpg.format = "ssh";
    };
    kitty = {
      enable = true;
      font.name = "Comic Code Ligatures";
      settings = {
        window_margin_width = 5;
        background_opacity = 0.9;
        background_blur = 32;
      };
      themeFile = "tokyo_night_night";
    };
    starship = {
      enable = true;
      settings.add_newline = false;
    };
    vscode = {
      enable = true;
      enableUpdateCheck = false;
      userSettings = {
        "editor.fontFamily" = "'Comic Code Ligatures', 'monospace', monospace";
        "editor.fontLigatures" = true;
        "editor.formatOnPaste" = true;
        "editor.formatOnSave" = true;
        "editor.lineNumbers" = "relative";
        "editor.rulers" = [ 80 ];
        "editor.tabSize" = 2;
        "extensions.ignoreRecommendations" = true;
        "git.enableCommitSigning" = true;
        "nix.enableLanguageServer" = true;
        "nix.serverPath" = "nixd";
        "telemetry.telemetryLevel" = "off";
        "terminal.integrated.minimumContrastRatio" = 1;
        "window.menuBarVisibility" = "toggle";
        "workbench.colorTheme" = "Tokyo Night";
        "workbench.iconTheme" = "material-icon-theme";
        "workbench.startupEditor" = "none";
      };
    };
    zoxide = {
      enable = true;
      options = [ "--cmd cd" ];
    };
  };
}

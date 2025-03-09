{ config, pkgs, ... }:

{
  home = {
    username = "thatoe";
    homeDirectory = "/home/thatoe";
    stateVersion = "24.11";
    packages = with pkgs; [
      nixd
      nixfmt-rfc-style
    ];
  };

  programs = {
    home-manager.enable = true;
    bash = {
      enable = true;
      initExtra = ''
        if [[ $(${pkgs.procps}/bin/ps --no-header --pid=$PPID --format=comm) != "fish" && -z ''${BASH_EXECUTION_STRING} ]]
        then
          shopt -q login_shell && LOGIN_OPTION='--login' || LOGIN_OPTION=""
          exec ${pkgs.fish}/bin/fish $LOGIN_OPTION
        fi
      '';
    };
    chromium = {
      enable = true;
      package = pkgs.brave;
      extensions = [
        "dnhpnfgdlenaccegplpojghhmaamnnfp" # Augmented Steam
        "nngceckbapebfimnlniiiahkandclblb" # Bitwarden Password Manager
        "mnjggcdmjocbbbhaepdhchncahnbgone" # SponsorBlock for YouTube - Skip Sponsorships
        "kdbmhfkmnlmbkgbabkdealhhbfhlmmon" # SteamDB
        "hipekcciheckooncpjeljhnekcoolahp" # Tabliss - A Beautiful New Tab
        "lcbjdhceifofjlpecfpeimnnphbcjgnc" # xBrowserSync
      ];
    };
    ghostty = {
      enable = true;
      settings = {
        background-opacity = 0.9;
        background-blur-radius = 32;
        font-family = "Comic Code Liguatures";
        font-size = 11;
        theme = "tokyonight";
      };
    };
    git = {
      enable = true;
      userEmail = "thatoe@pm.me";
      userName = "Ye Thatoe Kyaw";
      signing = {
        signByDefault = true;
        key = "${config.home.homeDirectory}/.ssh/id_ed25519.pub";
      };
      extraConfig = {
        gpg.format = "ssh";
        push.autoSetupRemote = true;
        tag.forceSignAnnotated = true;
      };
    };
    fish = {
      enable = true;
      interactiveShellInit = ''
        set fish_greeting
        fish_vi_key_bindings
      '';
      shellAliases =
        let
          flake = "${config.home.homeDirectory}/development/nix-config";
        in
        {
          ns = "sudo nixos-rebuild switch --flake ${flake}";
          nu = "nix flake update --flake ${flake}";
        };
    };
    fzf.enable = true;
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
    vscode = {
      enable = true;
      profiles.default = {
        enableUpdateCheck = false;
        userSettings = {
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
          "workbench.colorTheme" = "Tokyo Night";
          "workbench.iconTheme" = "material-icon-theme";
          "workbench.startupEditor" = "none";
        };
      };
    };
    zoxide.enable = true;
  };

  gtk = {
    enable = true;
    iconTheme = {
      name = "Papirus-Dark";
      package = pkgs.papirus-icon-theme;
    };
    theme = {
      name = "Tokyonight-Dark";
      package = pkgs.tokyonight-gtk-theme.override {
        colorVariants = [ "dark" ];
        tweakVariants = [ "black" ];
      };
    };
  };

  home.pointerCursor = {
    name = "Bibata-Modern-Classic";
    package = pkgs.bibata-cursors;
    size = 24;
    gtk.enable = true;
  };
}

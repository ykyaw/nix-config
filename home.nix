{
  config,
  lib,
  osConfig,
  pkgs,
  ...
}:

{
  home = {
    username = "thatoe";
    homeDirectory = "/home/thatoe";
    stateVersion = "25.11";
    packages = with pkgs; [
      bruno
      dbeaver-bin
      discord
      lazygit
      qbittorrent
      spotify
      teams-for-linux
      xclicker
      yazi
    ];
  };

  programs = {
    brave = {
      enable = true;
      extensions = [
        { id = "dnhpnfgdlenaccegplpojghhmaamnnfp"; } # Augmented Steam
        { id = "ghmbeldphafepmbegfdlkpapadhbakde"; } # Proton Pass: Free Password Manager
        { id = "mnjggcdmjocbbbhaepdhchncahnbgone"; } # SponsorBlock for YouTube - Skip Sponsorships
        { id = "kdbmhfkmnlmbkgbabkdealhhbfhlmmon"; } # SteamDB
        { id = "dbepggeogbaibhgnhhndojpepiihcmeb"; } # Vimium
      ];
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
    ghostty = {
      enable = true;
      settings = {
        command = "${lib.getExe pkgs.fish} --login --interactive";
        font-family = builtins.elemAt osConfig.fonts.fontconfig.defaultFonts.monospace 0;
        theme = "Catppuccin Mocha";
      };
    };
    git = {
      enable = true;
      settings = {
        user = {
          email = "thatoe@pm.me";
          name = "Ye Thatoe Kyaw";
        };
        push.autoSetupRemote = true;
      };
      signing = {
        format = "ssh";
        key = "${config.home.homeDirectory}/.ssh/id_ed25519.pub";
        signByDefault = true;
      };
    };
    home-manager.enable = true;
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
      mutableExtensionsDir = false;
      profiles.default = {
        enableUpdateCheck = false;
        enableExtensionUpdateCheck = false;
        extensions = with pkgs.vscode-extensions; [
          catppuccin.catppuccin-vsc
          catppuccin.catppuccin-vsc-icons
          dart-code.dart-code
          dart-code.flutter
          dbaeumer.vscode-eslint
          eamodio.gitlens
          esbenp.prettier-vscode
          firsttris.vscode-jest-runner
          github.copilot
          github.copilot-chat
          graphql.vscode-graphql
          graphql.vscode-graphql-syntax
          jnoortheen.nix-ide
          stkb.rewrap
          streetsidesoftware.code-spell-checker
          usernamehw.errorlens
          vscodevim.vim
        ];
        languageSnippets = {
          dart = {
            fontLoader = {
              prefix = "fontLoader";
              body = "await (FontLoader('Roboto')..addFont(rootBundle.load('assets/fonts/Roboto-Regular.ttf'))).load();";
              description = "Load the Roboto font for testing";
            };
            golden = {
              prefix = "golden";
              body = "await expectLater(find.byType(MaterialApp), matchesGoldenFile('golden/DO_NOT_COMMIT.png'));";
              description = "Add a golden test";
            };
          };
        };
        userSettings = {
          "editor.fontFamily" = builtins.elemAt osConfig.fonts.fontconfig.defaultFonts.monospace 0;
          "editor.formatOnPaste" = true;
          "editor.formatOnSave" = true;
          "editor.minimap.enabled" = false;
          "editor.rulers" = [ 80 ];
          "editor.tabSize" = 2;
          "extensions.ignoreRecommendations" = true;
          "git.enableCommitSigning" = true;
          "github.copilot.nextEditSuggestions.enabled" = true;
          "nix.enableLanguageServer" = true;
          "nix.serverPath" = "nixd";
          "telemetry.feedback.enabled" = false;
          "telemetry.telemetryLevel" = "off";
          "terminal.integrated.defaultProfile.linux" = "fish";
          "vim.foldfix" = true;
          "vim.highlightedyank.enable" = true;
          "vim.leader" = "<space>";
          "vim.smartRelativeLine" = true;
          "workbench.colorTheme" = "Catppuccin Mocha";
          "workbench.iconTheme" = "catppuccin-mocha";
          "workbench.startupEditor" = "none";
        };
      };
    };
    zoxide.enable = true;
  };

  dconf.settings = {
    "org/gnome/desktop/input-sources".xkb-options = [ "ctrl:nocaps" ];
    "org/gnome/desktop/interface" = {
      accent-color = "teal";
      clock-format = "12h";
      clock-show-weekday = true;
      color-scheme = "prefer-dark";
    };
    "org/gnome/desktop/peripherals/mouse".accel-profile = "flat";
    "org/gnome/desktop/screensaver".lock-enabled = false;
    "org/gnome/desktop/wm/preferences".resize-with-right-button = true;
    "org/gnome/GWeather4".temperature-unit = "centigrade";
    "org/gnome/shell" = {
      enabled-extensions = [
        "appindicatorsupport@rgcjonas.gmail.com"
        "blur-my-shell@aunetx"
        "caffeine@patapon.info"
        "hotedge@jonathan.jdoda.ca"
      ];
      favorite-apps = [
        "org.gnome.Nautilus.desktop"
        "brave-browser.desktop"
        "com.mitchellh.ghostty.desktop"
        "code.desktop"
        "dbeaver.desktop"
        "bruno.desktop"
        "teams-for-linux.desktop"
        "discord.desktop"
        "spotify.desktop"
        "steam.desktop"
      ];
    };
    "org/gnome/shell/extensions/blur-my-shell/coverflow-alt-tab".blur = false;
    "org/gnome/shell/extensions/blur-my-shell/dash-to-dock".blur = false;
    "org/gnome/shell/extensions/blur-my-shell/panel".blur = false;
    "org/gnome/shell/extensions/blur-my-shell/window-list".blur = false;
    "org/gnome/shell/extensions/caffeine" = {
      screen-blank = "always";
      show-notifications = false;
    };
    "org/gnome/shell/keybindings" = {
      switch-to-application-1 = [ "<Super>E" ];
      switch-to-application-2 = [ "<Super>B" ];
      switch-to-application-3 = [ "<Super>Return" ];
      switch-to-application-4 = [ "<Super>C" ];
    };
    "org/gnome/system/location".enabled = true;
    "org/gtk/settings/file-chooser".clock-format = "12h";
  };

  gtk = {
    enable = true;
    theme = {
      name = "Adwaita-dark";
      package = pkgs.gnome-themes-extra;
    };
    iconTheme = {
      name = "Papirus-Dark";
      package = pkgs.papirus-icon-theme;
    };
  };

  home.pointerCursor = {
    name = "Bibata-Modern-Classic";
    package = pkgs.bibata-cursors;
    size = 24;
    gtk.enable = true;
  };
}

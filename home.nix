{
  config,
  lib,
  pkgs,
  ...
}:

{
  home = {
    username = "thatoe";
    homeDirectory = "/home/thatoe";
    stateVersion = "25.05";
    packages = with pkgs; [
      android-studio
      bruno
      claude-code
      dbeaver-bin
      lazydocker
      lazygit
      ncdu
      nixd
      nixfmt-rfc-style
      qbittorrent
      sbctl
      spotify
      teams-for-linux
      yazi
    ];
  };

  wayland.windowManager.sway = {
    enable = true;
    config = {
      assigns = {
        "1" = [ { class = "^Brave-browser$"; } ];
        "2" = [ { class = "^Code$"; } ];
        "3" = [
          { class = "^net.novade.novade_lite$"; }
          { app_id = "^DBeaver$"; }
          { class = "^bruno$"; }
        ];
        "4" = [
          { class = "^teams-for-linux$"; }
          { class = "^discord$"; }
        ];
        "5" = [ { class = "^Spotify$"; } ];
        "6" = [ { class = "^steam$"; } ];
      };
      defaultWorkspace = "workspace number 1";
      fonts = {
        names = [ "Fira Code" ];
        size = 11.0;
      };
      input = {
        "type:pointer".accel_profile = "flat";
        "type:keyboard" = {
          xkb_numlock = "on";
          xkb_options = "ctrl:nocaps";
        };
      };
      keybindings =
        let
          alt = "Mod1";
          super = "Mod4";
        in
        lib.mkOptionDefault {
          "${alt}+Space" = "exec ${pkgs.rofi-wayland}/bin/rofi -show drun";
          "${alt}+Tab" = "exec ${pkgs.rofi-wayland}/bin/rofi -show window";
          "${super}+Tab" = "workspace back_and_forth";
          "${super}+b" = "exec ${pkgs.brave}/bin/brave";
          "${super}+c" = "exec ${pkgs.vscode}/bin/code";
          "--locked XF86AudioPlay" = "exec ${pkgs.playerctl}/bin/playerctl play-pause";
          "--locked XF86AudioNext" = "exec ${pkgs.playerctl}/bin/playerctl next";
          "--locked XF86AudioPrev" = "exec ${pkgs.playerctl}/bin/playerctl previous";
          "Print" = ''
            exec ${pkgs.grim}/bin/grim -g "$(${pkgs.slurp}/bin/slurp -d)" - | ${pkgs.wl-clipboard}/bin/wl-copy
          '';
        };
      menu = "${pkgs.rofi-wayland}/bin/rofi -show run";
      modifier = "Mod4";
      output.DP-2.resolution = "3440x1440@120Hz";
      terminal = "${pkgs.ghostty}/bin/ghostty";
      window.commands = [
        {
          command = "floating enable, sticky enable";
          criteria = {
            title = "^Picture in picture$";
          };
        }
        {
          command = "floating enable";
          criteria = {
            class = "^Emulator$";
            instance = "^qemu-system-x86_64$";
          };
        }
      ];
    };
  };

  programs.home-manager.enable = true;

  programs = {
    bash = {
      enable = true;
      profileExtra = ''
        [ "$(tty)" = "/dev/tty1" ] && exec sway
      '';
    };
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
        font-family = "Fira Code";
        theme = "GruvboxDarkHard";
        background-opacity = 0.9;
        background-blur = true;
        command = "${pkgs.fish}/bin/fish";
      };
    };
    git = {
      enable = true;
      userEmail = "thatoe@pm.me";
      userName = "Ye Thatoe Kyaw";
      signing = {
        format = "ssh";
        key = "${config.home.homeDirectory}/.ssh/id_ed25519.pub";
        signByDefault = true;
      };
      extraConfig.push.autoSetupRemote = true;
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
    vscode = {
      enable = true;
      mutableExtensionsDir = false;
      profiles.default = {
        enableUpdateCheck = false;
        enableExtensionUpdateCheck = false;
        extensions = with pkgs.vscode-extensions; [
          dart-code.dart-code
          dart-code.flutter
          dbaeumer.vscode-eslint
          eamodio.gitlens
          esbenp.prettier-vscode
          github.copilot
          github.copilot-chat
          graphql.vscode-graphql
          graphql.vscode-graphql-syntax
          jdinhlife.gruvbox
          jnoortheen.nix-ide
          pkief.material-icon-theme
          stkb.rewrap
          streetsidesoftware.code-spell-checker
          usernamehw.errorlens
          vscodevim.vim
        ];
        languageSnippets = {
          dart = {
            fontLoader = {
              body = "await (FontLoader('Roboto')..addFont(rootBundle.load('assets/fonts/Roboto-Regular.ttf'))).load();";
              description = "Load the Roboto font for testing";
              prefix = "fontLoader";
            };
            golden = {
              body = "await expectLater(find.byType(MaterialApp), matchesGoldenFile('golden/DO_NOT_COMMIT.png'));";
              description = "Add a golden test";
              prefix = "golden";
            };
          };
        };
        userSettings = {
          "editor.fontFamily" = "Fira Code";
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
          "workbench.colorTheme" = "Gruvbox Dark Hard";
          "workbench.iconTheme" = "material-icon-theme";
          "workbench.startupEditor" = "none";
        };
      };
    };
    zoxide.enable = true;
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

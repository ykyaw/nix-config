{ config, pkgs, ... }:

{
  home = {
    username = "thatoe";
    homeDirectory = "/home/thatoe";
    stateVersion = "25.05";
    packages = with pkgs; [
      nixd
      nixfmt-rfc-style
      sbctl
    ];
  };

  programs.home-manager.enable = true;

  programs = {
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
}

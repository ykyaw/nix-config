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
    stateVersion = "26.05";
  };

  programs = {
    fish = {
      enable = true;
      interactiveShellInit = ''
        set fish_greeting
        fish_vi_key_bindings
      '';
      shellAliases =
        let
          flake = "${config.home.homeDirectory}/Projects/nix-config";
        in
        {
          ns = "nixos-rebuild switch --sudo --flake ${flake}";
          nu = "nix flake update --flake ${flake}";
        };
    };
    fzf.enable = true;
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
    kitty = {
      enable = true;
      font.name = "Berkeley Mono";
      settings = {
        background_blur = 16;
        background_opacity = 0.9;
        shell = lib.getExe pkgs.fish;
      };
      themeFile = "Catppuccin-Mocha";
    };
    starship = {
      enable = true;
      settings.add_newline = false;
    };
    vscodium = {
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
              description = "Load the Roboto font for testing";
              body = "await (FontLoader('Roboto')..addFont(rootBundle.load('assets/fonts/Roboto-Regular.ttf'))).load();";
            };
            golden = {
              prefix = "golden";
              description = "Add a golden test";
              body = "await expectLater(find.byType(MaterialApp), matchesGoldenFile('golden/DO_NOT_COMMIT.png'));";
            };
          };
        };
        userSettings = {
          "editor.fontFamily" = "Berkeley Mono";
          "editor.fontLigatures" = true;
          "editor.formatOnPaste" = true;
          "editor.formatOnSave" = true;
          "editor.minimap.enabled" = false;
          "editor.rulers" = [ 80 ];
          "editor.tabSize" = 2;
          "extensions.ignoreRecommendations" = true;
          "git.enableCommitSigning" = true;
          "gitlens.plusFeatures.enabled" = false;
          "gitlens.rebaseEditor.openOnPausedRebase" = false;
          "gitlens.telemetry.enabled" = false;
          "nix.enableLanguageServer" = true;
          "terminal.integrated.defaultProfile.linux" = "fish";
          "terminal.integrated.initialHint" = false;
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
}

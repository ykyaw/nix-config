{
  config,
  lib,
  pkgs,
  ...
}:

{
  home = {
    username = "thatoe";
    stateVersion = "25.05";
    packages = with pkgs; [
      claude-code
      dbeaver-bin
      lazydocker
      lazygit
      ncdu
      nixd
      nixfmt-rfc-style
      qbittorrent
      spotify
      yazi
    ];
  };

  programs.home-manager.enable = true;

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
          flake = "${config.home.homeDirectory}/development/nix-config${lib.optionalString pkgs.stdenv.isDarwin "#macalania"}";
        in
        {
          ns = "sudo ${if pkgs.stdenv.isLinux then "nixos" else "darwin"}-rebuild switch --flake ${flake}";
          nu = "nix flake update --flake ${flake}";
        };
    };
    fzf.enable = true;
    ghostty = {
      enable = true;
      # ghostty build is currently broken on darwin
      package = if pkgs.stdenv.isLinux then pkgs.ghostty else pkgs.ghostty-bin;
      settings = {
        font-family = "Fira Code";
        theme = "GruvboxDarkHard";
        background-opacity = 0.9;
        background-blur = true;
        # TODO: switch to zsh as default shell on linux so that these commands are consistent
        command =
          if pkgs.stdenv.isLinux then
            "${pkgs.fish}/bin/fish --interactive"
          else
            "${pkgs.zsh}/bin/zsh --login -c 'fish --interactive'";
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
          "terminal.integrated.defaultProfile.osx" = "fish";
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

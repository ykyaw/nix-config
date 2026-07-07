{
  allowedUnfreePackages = [ "vscode-extension-anthropic-claude-code" ];

  flake.modules.homeManager.vscodium =
    { pkgs, ... }:
    let
      # https://redirect.github.com/prettier/prettier-vscode/issues/3931
      prettier = pkgs.vscode-utils.buildVscodeMarketplaceExtension {
        mktplcRef = {
          name = "prettier-vscode";
          publisher = "esbenp";
          version = "11.0.3";
          hash = "sha256-qWbHLWZOA40XpNAZ2hovPo8IzsTYjMENI5NY/7qfupk=";
        };
      };
    in
    {
      programs.vscodium = {
        enable = true;
        mutableExtensionsDir = false;
        profiles.default = {
          enableMcpIntegration = true;
          enableUpdateCheck = false;
          enableExtensionUpdateCheck = false;
          extensions =
            with pkgs.vscode-extensions;
            [
              anthropic.claude-code
              catppuccin.catppuccin-vsc
              catppuccin.catppuccin-vsc-icons
              dart-code.dart-code
              dart-code.flutter
              dbaeumer.vscode-eslint
              eamodio.gitlens
              firsttris.vscode-jest-runner
              graphql.vscode-graphql
              graphql.vscode-graphql-syntax
              jnoortheen.nix-ide
              mkhl.direnv
              stkb.rewrap
              streetsidesoftware.code-spell-checker
              usernamehw.errorlens
              vscodevim.vim
            ]
            ++ [ prettier ];
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
            "[dart]"."editor.rulers" = [ 160 ];
            "[typescript]"."editor.rulers" = [ 140 ];
            "claudeCode.preferredLocation" = "sidebar";
            "editor.fontFamily" = "Berkeley Mono";
            "editor.fontLigatures" = true;
            "editor.formatOnPaste" = true;
            "editor.formatOnSave" = true;
            "editor.minimap.enabled" = false;
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
    };
}
